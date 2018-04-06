Qualification = require "models/qualification/_base"

module.exports = class DeichV extends Qualification
	@relevant: [
		"Deichverteidigung"
		"Technischer Berater - Deichverteidigung"
	]
	@type: "Qualifikation"
	@levelRequirements: 
		2: [["Technischer Berater - Deichverteidigung"]]
		1: [["Deichverteidigung"]]
	@levelDisplay: 
		3: "TB DeichV"
		1: "DeichV"
	@validChecks: []
