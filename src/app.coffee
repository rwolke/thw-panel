Backbone = require "backbone"
_ = require "underscore"
window = require "window"

Config = require 'settings.json'
PDF = require 'pdf'
HelferListe = require 'models/HelferListe'
FileModel = require 'models/file'
FileView = require 'views/file'

Card = require 'pdf/card'

App = class MainApp extends Backbone.Router
	config: null
	
	routes:
		"*path(?*args)": "router"
	hl: null
	view: {}
	
	initialize: (opts)->
		uploads = [
				id: 'function'
				type: 'Function',
				desc: 'Auswertungen &amp; Abfragen &#x21D2; Helferverwaltung &#x21D2; Helfer mit/ohne Funktion dort: nur Helfer mit gewählter Funktion'
				name: 'Funktionen'
		,
				id: 'perms'
				type: 'Qualification'
				desc: 'Auswertungen &amp; Abfragen &#x21D2; Helferverwaltung &#x21D2; Qualifikationen &#x21D2; Ausbildung'
				name: 'Ausbildung'
		,
				id: 'qual'
				type: 'Qualification'
				desc: 'Auswertungen &amp; Abfragen &#x21D2; Helferverwaltung &#x21D2; Qualifikationen &#x21D2; Berechtigungen'
				name: 'Berechtigungen'
		,
				id: 'health'
				type: 'Qualification'
				desc: 'Auswertungen &amp; Abfragen &#x21D2; Helferverwaltung &#x21D2; Qualifikationen &#x21D2; Gesundheitsvorsorgen'
				name: 'Gesundheit'
		,
				id: 'xtra'
				type: 'Qualification'
				desc: 'Manuelle Ergänzung mit den Spalten: "Name", "Vorname", "Qualifikation", "Gültig ab" und "Gültig bis"'
				name: 'Ergänzung'
		,
				id: "ausb"
				type: "Ausbildung"
				desc: "Auswertungen &amp; Abfragen &#x21D2; Dienst &#x21D2; Ausbildungsstand"
				name: 'Ausbildungsstand'
		]

		for u in uploads
			mdl = FileModel u
			@view[u.id] = new FileView model: mdl
			@view[u.id].render()
	
	handleHelferliste: (data) ->
		@hl = new HelferListe
		for i,l of data
			if not _.isArray l
				@hl.addHelfer l
	
	handleQualification: (data) ->
		return false if not @hl
		for i,l of data
			if not _.isArray l
				@hl.addQualification l

	start: ->
		do Backbone.history.start
		
	select: ->
	
	print: ->
		@pdf = new PDF()
		cards = []
		list = @hl.where({Zug:'1. TZ'})
		for he in list
			cards.push new Card Config, @pdf, he
		
		offset = [5,77,149,221]
		for c,i in cards
			c.setXY offset[i%%4], 5
			do c.print
			do @pdf.addPage if i %% 4 is 3
		
		@pdf.pdf.save('card.pdf')

window.App = new MainApp();
window.App.start();

