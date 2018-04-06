Qualification = require "models/qualification/_base"

module.exports = class AGT extends Qualification
	@relevant: [
		"Jährl. Einsatzübung Atemschutz"
		"Jährl. Unterweisung Atemschutz"
		"Jährl. Atemschutzübung (Belastungsübung)"
		"Atemschutz, allgemein (G26.1)"
		"Atemschutz, leicht (G26.2)"
		"Atemschutz, schwer (G26.3)"
		"Ausbilder Atemschutz"
		"Bereichsausbilder CBRN"
		"Bereichsausbildung Atemschutz"
		"Bereichsausbildung Atemschutz - Teil 2 (CBRN)"
		"Atemschutz-Gerätewarte"
	]
	@dependencyChain: 
		"Atemschutz, schwer (G26.3)": ["Atemschutz, leicht (G26.2)", "Atemschutz, allgemein (G26.1)"]
		"Atemschutz, leicht (G26.2)": ["Atemschutz, allgemein (G26.1)"]
	@type: "Berechtigung"
	@levelRequirements: 
		256: [["Bereichsausbilder CBRN"]]
		128: [["Ausbilder Atemschutz"]]
		64: [["Atemschutz-Gerätewarte"]]
		32: [["Bereichsausbildung Atemschutz - Teil 2 (CBRN)"], ["Bereichsausbilder CBRN"]]
		16: [["Bereichsausbildung Atemschutz"]]
		8: [["Bereichsausbildung Atemschutz - Teil 2 (CBRN)"], ["Bereichsausbilder CBRN"]]
		4: [["Bereichsausbildung Atemschutz"]]
		2: [["Bereichsausbildung Atemschutz - Teil 2 (CBRN)"], ["Bereichsausbilder CBRN"]]
		1: [["Bereichsausbildung Atemschutz"]]
	@levelDisplay: (obj, x) ->
		return null if not x
		text = []
		if (x << 0) & 384 
			text.push "Ausb."
			if (x << 0) & 256
				text.push "CBRN" 
			else if (x << 0) & 2
				text.push "/ CBRN"
			else
				text.push "AGT"
		else 
			text.push if (x << 0) & 2 then "CBRN" else "AGT"
		if (x << 0) & 48
			text.push "PA"
		else if (x << 0) & 12
			text.push "Filter"
		else
			text.push "inaktiv"
		text.push "& Wart" if ((x << 0) & 448) is 64
		text.join ' '
	@validChecks: [
		{level: 60, req: "Jährl. Einsatzübung Atemschutz", display: "AGT-Ü"}
		{level: 60, req: "Jährl. Unterweisung Atemschutz", display: "UW AGT"}
		{level: 60, req: "Jährl. Atemschutzübung (Belastungsübung)", display: "Käfig"}
		{level: 32, req: "Atemschutz, schwer (G26.3)", display: "G26.3", degrade: 32, degradeDelay:12 }
		{level: 16, req: "Atemschutz, schwer (G26.3)", display: "G26.3", degrade: 16, degradeDelay:12 }
		{level: 8, req: "Atemschutz, leicht (G26.2)", display: "G26.2", degrade: 8, degradeDelay:12 }
		{level: 4, req: "Atemschutz, leicht (G26.2)", display: "G26.2", degrade: 4, degradeDelay:12 }
#		{level: 42, req: "Jährl. Einsatzübung CBRN", display: "CBRN-Übung"}
#		{level: 42, req: "Jährl. Unterweisung CBRN", display: "UW-CBRN"}
	]
