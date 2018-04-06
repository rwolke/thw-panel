Qualification = require "models/qualification/_base"

module.exports = class Kf extends Qualification
	@relevant: [
		"Jährl. Belehrung der Kraftfahrer THW",
		"KFZ-Fahrerlaubnis Klasse 1 (alt)",
		"KFZ-Fahrerlaubnis Klasse 1b (alt)",
		"KFZ-Fahrerlaubnis Klasse 2 (alt)",
		"KFZ-Fahrerlaubnis Klasse 3 (alt)",
		"KFZ-Fahrerlaubnis Klasse 4 (alt)",
		"KFZ-Fahrerlaubnis Klasse 5 (alt)",
		"KFZ-Fahrerlaubnis Klasse A",
		"KFZ-Fahrerlaubnis Klasse A1",
		"KFZ-Fahrerlaubnis Klasse B",
		"KFZ-Fahrerlaubnis Klasse BE",
		"KFZ-Fahrerlaubnis Klasse C",
		"KFZ-Fahrerlaubnis Klasse C1",
		"KFZ-Fahrerlaubnis Klasse C1E",
		"KFZ-Fahrerlaubnis Klasse CE",
		"KFZ-Fahrerlaubnis Klasse D",
		"KFZ-Fahrerlaubnis Klasse D1",
		"KFZ-Fahrerlaubnis Klasse D1E",
		"KFZ-Fahrerlaubnis Klasse DE",
		"KFZ-Fahrerlaubnis Klasse L",
		"KFZ-Fahrerlaubnis Klasse M",
		"KFZ-Fahrerlaubnis Klasse T",
		"Bereichsausbildung Kraftfahrer - Teil 1",
		"Bereichsausbildung Kraftfahrer - Teil 2",
		"Fahrgenehmigung THW",
	]
	@type: "Berechtigung"
	@dependencyChain: 
		"KFZ-Fahrerlaubnis Klasse CE": ["KFZ-Fahrerlaubnis Klasse C", "KFZ-Fahrerlaubnis Klasse C1E", "KFZ-Fahrerlaubnis Klasse C1"]
		"KFZ-Fahrerlaubnis Klasse C": ["KFZ-Fahrerlaubnis Klasse C1"]
		"KFZ-Fahrerlaubnis Klasse C1E": ["KFZ-Fahrerlaubnis Klasse C1"]
	@levelRequirements: 
		64: [["KFZ-Fahrerlaubnis Klasse CE"],["KFZ-Fahrerlaubnis Klasse 2 (alt)"]]
		32: [["KFZ-Fahrerlaubnis Klasse C"],["KFZ-Fahrerlaubnis Klasse CE"],["KFZ-Fahrerlaubnis Klasse 2 (alt)"]]
		16: [["KFZ-Fahrerlaubnis Klasse C1E"],["KFZ-Fahrerlaubnis Klasse CE"],["KFZ-Fahrerlaubnis Klasse 3 (alt)"]]
		8: [["KFZ-Fahrerlaubnis Klasse C1"],["KFZ-Fahrerlaubnis Klasse C1E"],["KFZ-Fahrerlaubnis Klasse C"],["KFZ-Fahrerlaubnis Klasse CE"],["KFZ-Fahrerlaubnis Klasse 3 (alt)"]]
		4: [["KFZ-Fahrerlaubnis Klasse BE"],["KFZ-Fahrerlaubnis Klasse CE"],["KFZ-Fahrerlaubnis Klasse C1E"],["KFZ-Fahrerlaubnis Klasse 3 (alt)"]]
		2: [["KFZ-Fahrerlaubnis Klasse B"],["KFZ-Fahrerlaubnis Klasse BE"],["KFZ-Fahrerlaubnis Klasse C1"],["KFZ-Fahrerlaubnis Klasse C1E"],["KFZ-Fahrerlaubnis Klasse C"],["KFZ-Fahrerlaubnis Klasse CE"],["KFZ-Fahrerlaubnis Klasse 3 (alt)"]]
		1: [["Fahrgenehmigung THW"]]
	@levelDisplay: 
		65: "Kf CE"
		33: "Kf C"
		17: "Kf C1E"
		9: "Kf C1"
		5: "Kf BE"
		3: "Kf B"
	@validChecks: [
		{level:  96, req: "Bereichsausbildung Kraftfahrer - Teil 2", expire:false, missing: 5, display: "Kf Teil 2"}
		{level: 126, req: "Bereichsausbildung Kraftfahrer - Teil 1", expire:false, missing: 5, display: "Kf Teil 1"}
		{level: 126, req: "Jährl. Belehrung der Kraftfahrer THW", display: "UW"}
		{level:  64, req: "KFZ-Fahrerlaubnis Klasse CE", missing: 0, display: "LKW", degrade: 64, degradeDelay:0}
		{level:  32, req: "KFZ-Fahrerlaubnis Klasse C", missing: 0, display: "LKW", degrade: 32, degradeDelay:0}
		{level:  16, req: "KFZ-Fahrerlaubnis Klasse C1E", missing: 0, display: "LKW", degrade: 16, degradeDelay:0}
		{level:   8, req: "KFZ-Fahrerlaubnis Klasse C1", missing: 0, display: "LKW", degrade: 8, degradeDelay:0}
	]
