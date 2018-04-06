Qualification = require "models/qualification/_base"

module.exports = class SpFu extends Qualification
	@relevant: [
		"Ausbilder Sprechfunk (analog)",
		"Ausbilder Sprechfunk (digital)",
		"Bereichsausbildung Sprechfunk-Führung",
		"Bereichsausbildung Sprechfunk-Grundausbildung",
		"Bereichsausbildung Sprechfunker - Analog",
		"Bereichsausbildung Digitalfunk/Analog auf Digital",
		"Verschwiegenh. Verpfl. gem. § 1 Abs. 1-3 Verpfl.G.",
	]
	@type: "Berechtigung"
	@levelRequirements: 
		16: [["Ausbilder Sprechfunk (digital)","Ausbilder Sprechfunk (analog)"]]
		8: [["Bereichsausbildung Sprechfunker - Analog","Bereichsausbildung Digitalfunk/Analog auf Digital"],["Bereichsausbildung Sprechfunk-Führung"]]
		4: [["Bereichsausbildung Sprechfunk-Grundausbildung"]]
		2: [["Bereichsausbildung Sprechfunker - Analog"]]
		1: [["Verschwiegenh. Verpfl. gem. § 1 Abs. 1-3 Verpfl.G."]]
	@levelDisplay: 
		16: "Ausb. SpFu"
		8: "SpFuFü"
		4: "SpFuGA"
		2: "SpFu - Analog"
		1: "SpFu - Verschw."
	@validChecks: [
		{level: 30, req: "Verschwiegenh. Verpfl. gem. § 1 Abs. 1-3 Verpfl.G.", expire:false, display: "Verschw."}
	]