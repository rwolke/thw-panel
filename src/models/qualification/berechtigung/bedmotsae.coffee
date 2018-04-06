Qualification = require "models/qualification/_base"

module.exports = class BedMotSae extends Qualification
	@relevant: [
	  "Ausbilder für Bediener Motorsägen"
		"Bereichsausbildung Bediener/-in Motorsäge Modul A"
		"Bereichsausbildung Bediener/-in Motorsäge Modul B"
		"Bereichsausbildung Bediener/-in Motorsäge Modul C"
		"THW-Motorkettensägenschein Modul A"
		"THW-Motorkettensägenschein Modul B"
		"THW-Motorkettensägenschein Modul C"
		"THW-Motorkettensägenschein Modul FA"
		"THW-Motorsägenschein Modul A/B"
		"THW-Motorsägenschein Modul C"
		"THW-Motorsägenschein nach GUV-I 8624 Modul 1"
		"Fachausbildung Motorsäge"
		"Jährl. Unterweisung Bed./-in Motorsäge"
	]
	@type: "Berechtigung"
	@name: "BedMotSä"
	@levelRequirements: 
		32: [["Ausbilder für Bediener Motorsägen"]]
		16: [
			["THW-Motorsägenschein Modul A/B","THW-Motorsägenschein Modul C","THW-Motorsägenschein Modul D"],
			["THW-Motorkettensägenschein Modul A","THW-Motorkettensägenschein Modul B","THW-Motorkettensägenschein Modul C"]
		],
		8: [
			["THW-Motorsägenschein Modul A/B","THW-Motorsägenschein Modul C"],
			["THW-Motorkettensägenschein Modul A","THW-Motorkettensägenschein Modul B"]
		],
		4: [
			["THW-Motorsägenschein Modul A/B"],
			["THW-Motorkettensägenschein Modul A"],
			["THW-Motorsägenschein nach GUV-I 8624 Modul 1"]
		],
		1: [["THW-Motorkettensägenschein Modul FA"], ["Fachausbildung Motorsäge"]]
	@levelDisplay: 
		32: "Ausb. BedMotSä"
		16: "BedMotSä - Korb"
		8: "BedMotSä"
		4: "BedMotSä klein"
		2: "BedMotSä mini"
		1: "BedMotSä FA"
	@validChecks: [
		{level: 63, req: "Jährl. Unterweisung Bed./-in Motorsäge", display: "UW"}
	]