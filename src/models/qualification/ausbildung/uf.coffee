QualAusb = require "models/qualification/ausbildung/_base"

module.exports = class UF extends QualAusb
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
		"FüS / Fachteil Bergung",
		"FüS / Fachteil FGr Elektro",
		"FüS / Fachteil FGr FK FmTr",
		"FüS / Fachteil FGr FK Führungsgehilfe",
		"FüS / Fachteil FGr Ortung",
		"FüS / Fachteil FGr Räumen",
		"FüS / Fachteil FGr Wassergefahren",
		"FüS / Führungsteil Bergung",
		"FüS / Führungsteil FGr B-O-R-SP",
		"FüS / Führungsteil FGr BrB-Öl-W",
		"FüS / Führungsteil FGr Elektro",
		"FüS / Führungsteil FGr FK-LogFü-ZTr",
		"FüS / Führungsteil FGr Ortung",
		"FüS / Führungsteil FGr Wassergefahren",
	]
	@dependencyChain: {}
	@topic: "UF"
	@type: "Ausbildung"
	@levelRequirements: 
		128: [["Fachausbildung Führung und Kommunikation","FüS / Fachteil FGr FK FmTr"]]
		64: [["Fachausbildung Führung und Kommunikation","FüS / Fachteil FGr FK Führungsgehilfe"]]
		32: [["Fachausbildung Zugtrupp","Fachausbildung Zugtrupp"]]
		16: [["Fachausbildung Räumen","FüS / Fachteil FGr Räumen"]]
		8: [["Fachausbildung Wassergefahren","FüS / Fachteil FGr Wassergefahren"]]
		4: [["Fachausbildung Ortung","FüS / Fachteil FGr Ortung"]]
		2: [["Fachausbildung Elektroversorgung","FüS / Fachteil FGr Elektro"]]
		1: [["Fachausbildung Bergung","FüS / Fachteil Bergung"]]
	@levelDisplay: (obj, x) ->
		return null if x is 0
		return "Führungsgehilfe" if x is 64
		return "FK FmTr" if x is 128
		list = 
			1: ['B', 'Bergung'],
			2: ['E', 'Elektroversorgung'],
			4: ['O', 'Ortung']
			8: ['W', 'Wassergefahren']
			16: ['R', 'Räumen']
			32: ['ZTr', 'Zugtrupp']
		return list[x][1] if x of list
		sel = []
		for i,l of list
			if (i & x) is (i << 0)
				sel.push l[0]
		sel = do sel.sort
		return sel.slice(0,-1).join(', ') + ' & ' + sel.slice(-1).join('')
	@validChecks: []
