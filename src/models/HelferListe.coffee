Backbone = require "backbone"
_ = require "underscore"

Helfer = require "models/Helfer"

class HelferListe extends Backbone.Collection
	model: Helfer
	modelId: (attr) -> 
		attr.Name + ', ' + attr.Vorname
	addHelfer: (line) -> 
		@add line, {validate:true}
	addQualification: (line) -> 
		if he = @get @modelId line 
			he.addQualification line
	
module.exports = HelferListe