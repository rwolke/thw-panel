Backbone = require "backbone"

class Helfer extends Backbone.Model
	@qualificationModuleList: []
	@staticInit: ->
		qualificationListFiles = require.context 'models/qualification', true, /.\/(?!_).*\.coffee$/
		for i,m of qualificationListFiles.keys()
			@qualificationModuleList.push qualificationListFiles m

	qualification: null
	dataset: null
	initialize: (attr, opts) ->
		@qualification = {}
		@dataset = []
		@collection.on "add", @onNew
	
	_genFunktion: (fkt) ->
		m = "Männlich" is @get "Geschlecht"
		parts = @get('Funktion').split /[ -]/
		for f in parts
			if "/in" is f.substr -3
				f = f.substr 0, f.length-3
				if f is "Leiter"
					return if m then f + " FGr FK" else f + "in FGr FK"
				return if m then f else f + "in"
			if "/r" is f. substr 0, f.length-2
				f = f.substr 0, f.length-2
				return if m then f + "r" else f
			return if m then "Koch" else "Köchin OV" if f is "Koch/Köchin OV" 
		return "- unbekannt -"
	
	onNew: =>
		@set("Titel", @_genFunktion(@get('Funktion')), silent:true)
		val = @get('Einheit').split ', '
		@set("Zug", val[0], silent:true) 
		if val.length is 2
			@set("Gruppe", val[1], silent:true)
	
	validate: (attrs, options) ->
		# combine state and attr => should be comlete and valid
		state = Object.assign {}, @attributes, attrs
		for r in ["Name","Vorname","Geschlecht","Status","Funktion","Einheit"]
			return false if not state[r]?
	
	addQualification: (line) ->
		if line["Abschluss"]?
			obj = 
				name: line["Abschluss"]
				percent: line["% über"]
		else
			obj = 
				name: line["Qualifikation"],
				von: line["Gültig ab"],
				bis: line["Gültig bis"]
		
		@dataset.push obj
		for i,m of @constructor.qualificationModuleList
			if not id = m.getID obj, @
				continue
			if not @qualification[m.type]?
				@qualification[m.type] = {} 
			if not @qualification[m.type][id]?
				@qualification[m.type][id] = new m obj, @
			@qualification[m.type][id].add obj, @
	
	prepareAusbildung: ->
		result = order:[]
		if @qualification.AusbildungAktuell?
			for a,b of @qualification.AusbildungAktuell
				continue if not do b.prepare
				result.order.push a
				result[a] = b.display
				delete result[a].color
		
		if @qualification.Ausbildung?
			list = ['Fue', 'UF', 'Fach']
			for i in list
				if i of @qualification.Ausbildung
					continue if not do @qualification.Ausbildung[i].prepare
					result.order.push i
					result[i] = @qualification.Ausbildung[i].display
					delete result[i].color
		return result

	prepareOther: ->
		list = Object.assign {}, (@qualification.Qualifikation || {}), (@qualification.Berechtigung || {})
		result = order: []
		for i,o of list
			continue if not do o.prepare
			result.order.push i
			result[i] = o.display
		result.order = do result.order.sort
		return result

	prepare: ->
		@dataset.sort (a,b) ->
			x = a.name.localeCompare b.name
			return x if x isnt 0
			a.von - b.von
		@set 'source', @dataset
		@set 'valid', @qualification.Status?.EB?
		return false if not @get 'valid'

		do @qualification.Status.EB.prepare
		@set 'EB', @qualification.Status.EB.display
		@set 'Ausbildung', do @prepareAusbildung
		@set 'Berechtigungen', do @prepareOther

do Helfer.staticInit

module.exports = Helfer