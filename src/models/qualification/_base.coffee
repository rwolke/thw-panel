Backbone = require "backbone"
_ = require "underscore"
dateMax = require 'date-fns/max'
dateMin = require 'date-fns/min'
dateCmp = require 'date-fns/compare_asc'
dateAddMonths = require 'date-fns/add_months'
dateDiffMonth = require 'date-fns/difference_in_months'

class Qualification
	@type: null
	@relevant: []
	@getID: (obj, he)-> 
		return null if obj.percent?
		if -1 isnt @relevant.indexOf obj.name then @name else null
	@levelRequirements: {}
	@levelDisplay: {}
	@validChecks: []
	
	level: 0
	list: null
	failLevel: 0
	fails: null

	_fixDependencyChain: ->
		for d,rList of @constructor.dependencyChain
			continue if not _.has @list, d
			for i,r of rList
				continue if not _.has @list, r
				continue if @list[r].bis and @list[r].bis > @list[d].bis
				if _.has(@list, d) 
					@list[r].bis = @list[d].bis
				else
					delete @list[r]
	
	_calcLevel: ->
		@level = 0
		if typeof @constructor.levelRequirements is "function"
			return @level = @constructor.levelRequirements @, @list 
		for i,lr of @constructor.levelRequirements
			for j,r of lr
				req = true
				for key in r
					if not _.has @list, key 
						req = false 
					#else if @list[key].bis and dateCmp(Date.now(), @list[key].bis) > 0
					#	console.log key
					#	req = false 
				if req
					@level |= i
					break
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
		
		if display isnt null and typeof display is "object" 
			@failLevel = display.failLevel if 'failLevel' of display
			return display.display
		return display
	
	_getExpire: (date, degradeDelay) ->
		return 4 if date is null
		x = dateDiffMonth date, Date.now()
		return 0 if x >= 3
		return 1 if x > 0
		return 3 if degradeDelay and x + degradeDelay <= 0
		return 1 if Object.is x, 0
		return 2
	
	_calcValid: ->
		# 4 nicht vorhanden
		# 3 12 Monate abgelaufen (degrade)
		# 2 abgelaufen
		# 1 3 Monate verbleibend
		@fails = _.filter @fails, (v) -> v.keep
		@failLevel = -1
		for i,vc of @constructor.validChecks
			continue if (@level & vc.level) is 0
			f = 0
			expire = null
			if _.has @list, vc.req
				if 'expire' of vc
					if vc.expire is false
						f = 0
					else
						f = @_getExpire dateAddMonths @list[vc.req].von, vc.expire
						expire = dateAddMonths @list[vc.req].von, vc.expire
				else
					f = @_getExpire @list[vc.req].bis
					expire = @list[vc.req].bis
			else
				f = if 'missing' of vc then vc.missing else 4
			if f is 0
				@failLevel = 0 if @failLevel < 0
				continue
			err = 
				req: vc.req
				err: vc.display
				int: vc.internal || null
				keep: vc.keep || false
				level: f
			if f < 4
				err.date = expire
			if 'degrade' of vc and (@level & vc.degrade) > 0
				@level -= vc.degrade 
				return do @_calcValid
			@fails.push err
			@failLevel = err.level if err.level > @failLevel

	_date: (str) ->
		d = str.split '.'
		return null if d.length isnt 3
		new Date d[2], (d[1]-1), d[0]
	
	constructor: ->
		@list = {}
	
	add: (obj, he) ->
		return if not @constructor.getID obj, he
		d = 
			von: @_date obj.von
			bis: @_date obj.bis
		if @list[obj.name]?
			@list[obj.name].von = dateMin @list[obj.name].von, d.von
			@list[obj.name].bis = dateMax @list[obj.name].bis, d.bis
		else
			@list[obj.name] = d
	
	prepare: ->
		do @_fixDependencyChain
		do @_calcLevel
		do @_calcValid
		return false if not @level
		text = do @_getLevelDisplay
		return false if not text
		@display = text: text
		@display.color = switch @failLevel
			when 0 then "green"
			when 1 then "yellow"
			when 2 then "red"
			when 4 then "attention"
			else "blank"
		@display.fails = @fails
		return true

module.exports = Qualification