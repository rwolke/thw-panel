Qualification = require "models/qualification/_base"

class QualAusb extends Qualification
	_getLevelDisplay: ->
		if typeof @constructor.levelDisplay isnt "function"
			max = 0
			display = null
			for i,ld of @constructor.levelDisplay
				if (i & @level) is i << 0 and i << 0 > max
					max = i << 0
					display = ld
		else
			display = @constructor.levelDisplay @, @level
		
		if typeof display is "object" 
			@failLevel = display.failLevel if 'failLevel' of display
			return display.display
		return display
	
	prepare: ->
		do @_fixDependencyChain
		do @_calcLevel
		do @_calcValid
		return false if not @level
		@display = 
			topic: @constructor.topic
			text: do @_getLevelDisplay
			fails: []
		return true

module.exports = QualAusb