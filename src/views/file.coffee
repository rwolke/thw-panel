Backbone = require "backbone"

module.exports = class FileView extends Backbone.View
	## static
	template = require 'templates/file'
	
	## dynamic
	file: null
	events: 
		"click .close": "hide"
		"change input": "change"
		"drag form": "stopit"
		"dragstart": "stopit"
		"dragover": "dragover"
		"dragenter": "dragover"
		"dragend": "dragleave"
		"dragleave": "dragleave"
		"drop": "drop"
	
	updateStatus: (mdl, v) => @el.querySelector('.alert').className = "alert alert-#{v}"
	updateResult: (mdl, v) => @el.querySelector('.result').innerHTML = v
	
	stopit: (e) ->
		do e.preventDefault
		do e.stopPropagation
	dragover: (e) =>
		if 'success' isnt @model.get 'status'
			@model.set 'status', 'warning'
		@stopit e
	dragleave: (e) =>
		if 'success' isnt @model.get 'status'
			@model.set 'status', 'info'
		@stopit e
	drop: (e) =>
		f =  if e.originalEvent.dataTransfer.files then e.originalEvent.dataTransfer.files[0] else null
		@handleFile f
		@stopit e
	change: (e) =>
		f =  if e.target.files then e.target.files[0] else null
		@handleFile f
	
	initialize: ->
		$(document.querySelector('.uploads')).append @el
		@model.bind "change:status", @updateStatus
		@model.bind "change:result", @updateResult
		@model.bind "change:encoding", => do @handleFile
	render: ->
		@$el.html template @model.attributes
	
	handleFile: (file) =>
		@file = file if file

		@model.set 'status', 'danger'
		if not @model.get('encoding').length
			@model.set 'result', "Kein passender Zeichensatz für die Datei gefunden!"
			return
		
		if @file
			fr = new FileReader()
			fr.onload = @model.handleFile
			fr.readAsText @file, @model.get('encoding')[0]
		else
			@model.set 'result', "Datei konnte nicht geladen werden!"

	