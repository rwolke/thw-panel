Qualification = require "models/qualification/_base"

module.exports = class Ausbilder extends Qualification
	@relevant: {
		"Ausbilder Einsatzgerüstsystem": "Ausb. EGS"
		"Ausbilder und Prüfer Grundausbildung": "PGA"
		"Prüfer Grundausbildung, Cu": "PGA"
		"Befähigte Person Elektro": "BP-E"
		"Befähigte Person Technik": "BP-T"
		"Ladungssicherung im THW": "LadSi"
		"Ortsbeauftragte im THW": "OB"
		"Technische Hilfe auf DB-Anlagen": "TH Bahn"
		"Anlegen und Durchführen von Übungen": "Übungen"
		"RettSan": "RS"
		"San": "San"
	}
	@type: "Qualifikation"
	@getID: (obj, he)->
		return null if obj.percent?
		if obj.name of @relevant then @relevant[obj.name] else null
	@levelRequirements: (obj, list) -> 1
	@levelDisplay: (obj, level) -> @relevant[obj.selected]

	selected: null
	constructor: (obj) ->
		super(obj);
		@selected = obj.name
	
