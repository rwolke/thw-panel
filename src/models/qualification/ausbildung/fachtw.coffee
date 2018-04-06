QualAusb = require "models/qualification/ausbildung/_base"

module.exports = class FachausbildungProgress extends QualAusb
	@relevant: {
		"Ausb. für Bootsführer-Anwärter": ["FGr W (A)", "FGr W (B)"]
		"Basis II der BGr": ["B1", "B2 (A)", "B2 (B)"]
		"Basis II der FGr E": ["FGr E"]
		"Basis II der FGr FK": []
		"Basis II der FGr W": ["FGr W (A)", "FGr W (B)"]
		"Basis II der FGr O": []
		"Basis II der FGr TW": []
		"Basis II der FGr Bel A": []
		"Basis II der FGr I": []
		"Basis II des ZTr": ["ZTr"]
		"GA-Abschlussprüfung": ["1. GAGr", "2. GAGr"]
		"GA-Abschlussprüfung, angepasst": ["1. GAGr", "2. GAGr"]
		"Sprechfunk (SprFuFü)": ["1. GAGr", "2. GAGr"]
		"Jugendausbildung": []
	}
	@shortname: {
		"Ausb. für Bootsführer-Anwärter": "BoFüAnw"
		"Basis II der BGr": "Fach B"
		"Basis II der FGr E": "Fach E"
		"Basis II der FGr FK": "Fach FK"
		"Basis II der FGr W": "Fach W"
		"Basis II der FGr O": "Fach O"
		"Basis II der FGr TW": "Fach TW"
		"Basis II der FGr Bel A": "Fach Bel"
		"Basis II der FGr I": "Fach I"
		"Basis II des ZTr": "Fach ZTr"
		"GA-Abschlussprüfung": "GA"
		"GA-Abschlussprüfung, angepasst": "GA"
		"Sprechfunk (SprFuFü)": "SprFuFü"
		"Jugendausbildung": "Jugend"
	}
	@dependencyChain: {}
	@type: "AusbildungAktuell"
	@topic: "akt."
	@getID: (obj, he)-> 
		if @relevant[obj.name]? 
			return obj.name if -1 isnt @relevant[obj.name].indexOf he.get('Zug')
			return obj.name if -1 isnt @relevant[obj.name].indexOf he.get('Gruppe')
		return null
	@levelRequirements: (obj, list) -> 1
	@levelDisplay: (obj, level) -> 
		debugger
		@shortname[obj.selected] + ': ' + obj.percent + '%'
	@validChecks: []

	selected: null
	add: (x) ->
	constructor: (obj) ->
		super(obj);
		@selected = obj.name
		@percent = obj.percent
	
