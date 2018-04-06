Qualification = require "models/qualification/_base"

module.exports = class BoFue extends Qualification
	@relevant: [
		"Jährl. Belehrung der Kraftfahrer THW",
		"Seh- und Hörtest für Bootsführer nach DIN 58220",
		"Spez 25 - Bootsführer See (alter Teil 2)",
		"THW-Bootsführerschein Binnen",
		"THW-Bootsführerschein See",
		"Grundlagen Bootsführer Binnen",
		"Grundlagen Bootsführer See",
		"Fahrgenehmigung THW",
		"Bootsführer Aufbau Binnen/See",
		"Bootsführer Binnen",
		"Bootsführer See",
		"Bootsführer-Binnen, extern erworben",
		"Bootsführer-See, extern erworben",
		"Bootsführerschein KatS muß älter als 3 Jahre sein",
		"Ausbildung Bootsführer-Anwärter",
		"Fortbildung Bootsführer Binnen",
		"Fortbildung Bootsführer See",
	]
	@type: "Berechtigung"
	@levelRequirements: 
		4: [["THW-Bootsführerschein See"]]
		2: [["THW-Bootsführerschein Binnen"]]
	@levelDisplay: 
		8: "BoFü Ausb."
		6: "BoFü See & Binnen"
		4: "BoFü See"
		2: "BoFü Binnen"
		1: "BoFü manuell"
	@validChecks: [
		{level: 7, req: "Fahrgenehmigung THW", expire:false, display: "FahrGenehm"}
		{level: 7, req: "Jährl. Belehrung der Kraftfahrer THW", display: "UW"}
		{level: 2, req: "THW-Bootsführerschein Binnen", expire:60, display: "FB Binnen"}
		{level: 4, req: "THW-Bootsführerschein See", expire:60, display: "FB See"}
	]

	_fixDependencyChain: ->
		super()
		if "THW-Bootsführerschein See" of @list and "Fortbildung Bootsführer See" of @list
			@list["THW-Bootsführerschein See"].von = @list["Fortbildung Bootsführer See"].von
		if "THW-Bootsführerschein Binnen" of @list and "Fortbildung Bootsführer Binnen" of @list
			@list["THW-Bootsführerschein Binnen"].von = @list["Fortbildung Bootsführer Binnen"].von
