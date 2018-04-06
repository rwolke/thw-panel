Qualification = require "models/qualification/_base"

module.exports = class Masch extends Qualification
	@relevant: [
		"Maschinist Netzersatzanlagen",
		"Maschinist Stromerzeugungsaggregat",
	]
	@type: "Berechtigung"
	@levelRequirements: 
		2: [["Maschinist Netzersatzanlagen"]]
		1: [["Maschinist Stromerzeugungsaggregat"]]
	@levelDisplay: 
		2: "Masch NEA"
		1: "Masch SEA"
	@validChecks: []
