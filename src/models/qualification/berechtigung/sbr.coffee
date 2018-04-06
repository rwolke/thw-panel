Qualification = require "models/qualification/_base"

module.exports = class SBr extends Qualification
	@relevant: [
		"Schweißen im THW",
		"Schweißen im THW_",
		"Thermisches Trennen im THW",
	]
	@type: "Berechtigung"
	@levelRequirements: 
		2: [["Thermisches Trennen im THW"]]
		1: [["Schweißen im THW"],["Schweißen im THW_"]]
	@levelDisplay: 
		3: "SBr"
		2: "Brennschn."
		1: "Schweißen"
	@validChecks: []
