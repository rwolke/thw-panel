QualAusb = require "models/qualification/ausbildung/_base"

module.exports = class Fach extends QualAusb
	@relevant: [
		"Fachausbildung Bergung",
		"Fachausbildung Brückenbau",
		"Fachausbildung Elektroversorgung",
		"Fachausbildung Führung und Kommunikation",
		"Fachausbildung Logistik Trupp Verpflegung",
		"Fachausbildung Motorsäge",
		"Fachausbildung Ortung",
		"Fachausbildung Räumen",
		"Fachausbildung Trinkwasserversorgung",
		"Fachausbildung Wassergefahren",
		"Fachausbildung Wasserschaden / Pumpen",
		"Fachausbildung Zugtrupp",
	]
	@dependencyChain: {}
	@type: "Ausbildung"
	@topic: "Fach"
	@levelRequirements: 
		2048: [["Fachausbildung Bergung"]]
		1024: [["Fachausbildung Brückenbau"]]
		512: [["Fachausbildung Elektroversorgung"]]
		256: [["Fachausbildung Führung und Kommunikation"]]
		128: [["Fachausbildung Logistik Trupp Verpflegung"]]
		64: [["Fachausbildung Motorsäge"]]
		32: [["Fachausbildung Ortung"]]
		16: [["Fachausbildung Räumen"]]
		8: [["Fachausbildung Trinkwasserversorgung"]]
		4: [["Fachausbildung Wassergefahren"]]
		2: [["Fachausbildung Wasserschaden / Pumpen"]]
		1: [["Fachausbildung Zugtrupp"]]
	@levelDisplay: (obj, x) ->
		return null if x is 0
		list = 
			2048: ['B', 'Bergung'],
			1024: ["BrB", "Brückenbau"]
			512: ["E", "Elektroversorgung"]
			256: ["FK", "FK"]
			128: ["L", "LogTruppVerpfl."]
			64: ["MotSä", "Motorsäge"]
			32: ["O", "Ortung"]
			16: ["R", "Räumen"]
			8: ["TW", "TW"]
			4: ["W", "Wassergefahren"]
			2: ["WP", "WP"]
			1: ["ZTr", "Zugtrupp"]
		return list[x][1] if x of list
		sel = []
		for i,l of list
			if (i & x) is (i << 0)
				sel.push l[0]
		sel = do sel.sort
		return sel.slice(0,-1).join(', ') + ' & ' + sel.slice(-1).join('')
	@validChecks: []
