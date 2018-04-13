Qualification = require "models/qualification/_base"

module.exports = class PSAgA extends Qualification
	@relevant: [
		"PSAgA",
		"PSAgA-Multi",
		"PSAgA - UW",
		"PSAgA-Multi Auffrischung",
	]
	@type: "Berechtigung"
	@dependencyChain: 
		"PSAgA - UW": ["PSAgA"]
		"PSAgA-Multi Auffrischung": ["PSAgA","PSAgA-Multi","PSAgA - UW"]
	@levelRequirements: 
		4: [["PSAgA-Multi"]]
		2: [["PSAgA-Multi"]]
		1: [["PSAgA"]]
	@levelDisplay: 
		4: "PSAgA-Multi"
		2: "PSAgA Mult inakt."
		1: "PSAgA"
	@validChecks: [
		{level: 7, req: "PSAgA", display: "UW"}
		{level: 4, req: "PSAgA-Multi", display: "Multi", degrade: 4, degradeDelay:0, keepFail:true }
	]
