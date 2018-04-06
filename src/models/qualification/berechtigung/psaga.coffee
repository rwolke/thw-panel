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
		2: [["PSAgA-Multi"]]
		1: [["PSAgA"]]
	@levelDisplay: 
		2: "PSAgA-Multi"
		1: "PSAgA"
	@validChecks: [
		{level: 3, req: "PSAgA", display: "UW"}
		{level: 2, req: "PSAgA-Multi", display: "Multi"}
	]
