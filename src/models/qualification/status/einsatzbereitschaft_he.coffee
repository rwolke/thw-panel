Qualification = require "models/qualification/_base"

module.exports = class EB extends Qualification
	@relevant: [
		"Erste-Hilfe-Ausbildung",
		"Erste-Hilfe-Fortbildung",
		"Diphtherie",
		"Diphtherie Auffrischung",
		"Tetanus",
		"Tetanus Auffrischung",
		"Tauglichkeit THW",
		"Wiederholungsbelehrung gemäß § 12 ArbSchutzG",
		"Jährl. Unterweisung Gefahrgut",
		"Belehrung CBRN-Schutz im THW",
		"Hepatitis A",
		"Hepatitis B",
		"Grundausbildung",
		"Grundausbildung, angepasst",
	]
	@type: "Status"
	@dependencyChain: 
		"Erste-Hilfe-Fortbildung": ["Erste-Hilfe-Ausbildung"]
		"Diphtherie Auffrischung": ["Diphtherie"]
		"Tetanus Auffrischung": ["Tetanus"]
		"Hepatitis A Auffrischung": ["Hepatitis A"]
		"Hepatitis B Auffrischung": ["Hepatitis B"]
	@levelRequirements: 
		16: [["Diphtherie","Hepatitis A","Hepatitis B"]]
		8: [["Tetanus"]]
		4: [["Erste-Hilfe-Ausbildung"]]
		2: [["Belehrung CBRN-Schutz im THW","Jährl. Unterweisung Gefahrgut","Wiederholungsbelehrung gemäß § 12 ArbSchutzG"]]
		1: [["Grundausbildung","Tauglichkeit THW"], ["Grundausbildung","Atemschutz, allgemein (G26.1)"],["Grundausbildung"]]
	@levelDisplay: 
		31: "EINSATZBEREIT"
		29: {display: "bed. EB - UW fehlen", failLevel: 1} # -UW
		27: {display: "nicht EB - EH fehlt", failLevel: 2} # -EH
		25: {display: "nicht EB - EH & UW fehlen", failLevel: 2} # -EH & UW
		23: {display: "nicht EB - Impfungen fehlen", failLevel: 2} # -Tetanus
		21: {display: "nicht EB - Impf & UW fehlen", failLevel: 2} # -Tetanus & UW
		19: {display: "nicht EB - Impf & EH fehlen", failLevel: 2} # -Tetanus & EH
		17: {display: "nicht EB - Impf, EH & UW fehlen", failLevel: 2} # -Tetanus EH & UW
		15: {display: "bed. EB - Impfungen fehlen", failLevel: 1} # - weitere
		13: {display: "bed. EB - Impf & UW fehlen", failLevel: 1} # -weitere + UW
		11: {display: "nicht EB - Impf & EH fehlen", failLevel: 2} # - weitere, EH
		9: {display: "nicht EB - Impf, EH & UW fehlen", failLevel: 2} # - weitere, EH, UW
		7: {display: "nicht EB - Impfungen fehlen" , failLevel: 2}
		5: {display: "nicht EB - Impf & UW fehlen", failLevel: 2}
		3: {display: "nicht EB - Impf & EH fehlen", failLevel: 2}
		1: {display: "nicht EB - Impf, EH & UW fehlen", failLevel: 2}
	@validChecks: [
		{level: 31, req: "Tetanus", display: "Impfung", internal: "Tetanus"}
		{level: 31, req: "Diphtherie", display: "Impfung", internal:"Diphtherie"}
		{level: 31, req: "Hepatitis A", display: "Impfung", internal:"Hepatitis A"}
		{level: 31, req: "Hepatitis B", display: "Impfung", internal:"Hepatitis B"}
		{level: 31, req: "Erste-Hilfe-Ausbildung", display: "EH", degrade: 4, degradeDelay:0, keepFail:true }
		{level: 31, req: "Belehrung CBRN-Schutz im THW", display: "UW CBRN", degrade: 2, degradeDelay:0, keepFail:true}
		{level: 31, req: "Jährl. Unterweisung Gefahrgut", display: "UW Gefahrgut", degrade: 2, degradeDelay:0, keepFail:true}
		{level: 31, req: "Wiederholungsbelehrung gemäß § 12 ArbSchutzG", display: "UW ArbSchutz", degrade: 2, degradeDelay:0, keepFail:true}
#		{level:  1, req: "Tauglichkeit THW", display: "Tauglichkeit"}
	]
