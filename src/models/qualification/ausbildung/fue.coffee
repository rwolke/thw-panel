QualAusb = require "models/qualification/ausbildung/_base"

module.exports = class Fue extends QualAusb
	@relevant: [
		"Führung - Aufbau"
		"Ausbildung zum Zugführer"
		"Führen in der THW FüSt."
		"Fachberater in FüSt der Bedarfsträger"
	]
	@dependencyChain: {}
	@type: "Ausbildung"
	@topic: "Fü"
	@levelRequirements:
		8: [["Fachberater in FüSt der Bedarfsträger"]]
		4: [["Führen in der THW FüSt."]] 
		2: [["Ausbildung zum Zugführer"]]
		1: [["Führung - Aufbau"]]
	@levelDisplay: 
		12: "ZFü, FüSt & FB 1/2"
		8: "ZFü & FB 1/2"
		4: "ZFü & FüSt"
		2: "Zugführerausbildung"
		1: "Aufbau Führung"
	@validChecks: []
