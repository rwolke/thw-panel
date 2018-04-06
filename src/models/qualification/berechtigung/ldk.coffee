Qualification = require "models/qualification/_base"

module.exports = class Ldk extends Qualification
	@relevant: [
		"Anbaukran-Befähigung 10mt, extern erworben",
		"Anbaukran-Befähigung 17mt",
		"Anbaukran-Befähigung 27mt",
		"Anbaukran-Befähigung 6mt, extern erworben",
		"Ausbilder u. Prüfer LKW Ladekranbediener - FL",
		"Ausbilder und Prüfer LKW-Ladekranbediener",
		"Bereichsausbildung der Bediener/in Ladekran",
		"Fahrzeug-Anbaukran 10 mt, SL",
		"Jährl. Unterweisung Bed./-in Ladekran",
	]
	@type: "Berechtigung"
	@dependencyChain: {}
	@levelRequirements: 
		16: [["Ausbilder und Prüfer LKW-Ladekranbediener"]]
		8: [["Anbaukran-Befähigung 27mt"]]
		4: [["Anbaukran-Befähigung 17mt"]]
		2: [["Anbaukran-Befähigung 10mt"],["Anbaukran-Befähigung 10mt, extern erworben"],["Fahrzeug-Anbaukran 10 mt, SL"]]
		1: [["Anbaukran-Befähigung 6mt"],["Anbaukran-Befähigung 6mt, extern erworben"]]
	@levelDisplay: (obj, level) ->
		list = []
		list.push '27' if ((level << 0) & 8) > 0
		list.push '17' if ((level << 0) & 4) > 0
		list.push '10' if ((level << 0) & 2) > 0
		list.push '6' if ((level << 0) & 1) > 0
		return null if list.length is 0 
		list = if list.length is 1 then list[0] else list.slice(0,-1).join(', ') + ' & ' + list.slice(-1).join('')
		if level >= 16
			return 'Ausb. Ldk ' + list + 'mt'
		return 'Ldk '+list + 'mt'
	@validChecks: [
		{level: 31, req: "Jährl. Unterweisung Bed./-in Ladekran", display: "UW"}
	]
