Backbone = require "backbone"
DSV = require 'd3-dsv'
_ = require 'underscore'

class FileModel extends Backbone.Model
	@encodingList: ['UTF-8','ISO-8859-1']
	defaults:
		status: 'info'
		result: null
	data: null
	
	initialize: ->
		@set 'encoding', @constructor.encodingList

	_checkEncoding: (str) ->
		chars = "äöüÄÖÜß"
		for i in [0 ... chars.length]
			if -1 < str.indexOf chars[i]
				return true
		@set "encoding", @get('encoding').slice(1)
		return false
	
	_checkData: ->
		if not "columns" of @data
			@set "result", "Datei konnte nicht ausgewertet werden!"
			return false
		diff = _.difference(@constructor.cols, @data.columns)
		if diff.length
			return @set "result", "Es fehlen Spalten zur Auswertung: #{diff.join(', ')}"
			return false
		
		helfer = []
		for i,row of @data
			if _.isObject row
				helfer.push row.Name + ', ' + row.Vorname
		@set "result", "#{helfer.length} Datensätze von #{_.uniq(helfer).length} Helfern importiert"
		@set "status", "success"
		return true

	handleFile: (evt) =>
		if evt.target?.result?
			return if not @_checkEncoding evt.target.result
			@data = DSV.csvParse evt.target.result
			return do @_checkData
		return false
		
class FileFktModel extends FileModel
	@cols: [
		"Name",
		"Vorname",
		"Geschlecht",
		"Status",
		"Funktion",
		"Einheit"
	]
	handleFile: (evt) ->
		if super evt
			App.handleHelferliste @data

class FileQualModel extends FileModel
	@cols: [
		"Name"
		"Vorname"
		"Qualifikation"
		"Gültig ab"
		"Gültig bis"
	]
	handleFile: (evt) ->
		if super evt
			App.handleQualification @data

class FileAusbModel extends FileModel	
	@cols: [
		"Name"
		"Vorname"
		"Abschluss"
		"% über"
	]
	handleFile: (evt) ->
		if super evt
			App.handleQualification @data

module.exports = (data) ->
	switch data.type
		when "Qualification" then new FileQualModel data
		when "Function" then new FileFktModel data
		when "Ausbildung" then new FileAusbModel data
		else null
