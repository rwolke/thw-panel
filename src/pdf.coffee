jsPDF = require('jspdf')

#jsPDF.API.autoTable
#class MyPDF extends jsPDF
#	constructor: (orientation, unit, format) ->
#		super(orientation, unit, format)
	

class PDF
	pdf: null

	constructor: ->
		@pdf = new jsPDF("l")
	
	save: (filename) ->
		filename = 'a4.pdf' if not filename
		@pdf.save filename
	
	addPage: ->
		do @pdf.addPage

	getTextWidth: (cfg, text, fs) ->
		@pdf.setFont 'helvetica', cfg.style
		@cfg.fontSize = fs if fs
		return @pdf.getTextWidth text
	
	calcFontSize: (cfg, text, width) ->
		@pdf.setFont 'helvetica', cfg.style
		@pdf.setFontSize 10
		cw = @pdf.getTextWidth text
		return width / cw * 10
	
	_setFontSize: (cfg, text, width) ->
		if typeof cfg.fontSize is 'number'
			@pdf.setFontSize cfg.fontSize
			return cfg.fontSize / 2.83464
		
		@pdf.setFontSize 10
		cw = @pdf.getTextWidth text
		fs = width / cw * 10
		if cfg.fontSize[0] and fs < cfg.fontSize[0]
			return false 
		if cfg.fontSize[1] and fs > cfg.fontSize[1]
			fs = cfg.fontSize[1] 
		@pdf.setFontSize fs
		return fs / 2.83464

	_middleTextPos: (text, fh, height) ->
		H = fh * .75
		if text.match /[pgyqj]/
			fh *= .95
		else
			fh *= .75
		return H + (height - fh) / 2

	fitText: (cfg, x, y, text) ->
		@pdf.setFont 'helvetica', cfg.style
		cfg.angle = cfg.angle || 0
		cfg.align = null if cfg.align is "left"
		if cfg.angle is 0
			x += cfg.padding
			w = cfg.width - 2 * cfg.padding
			x += switch cfg.align
				when "right" then w
				when "center" then w/2
				else 0
			fh = @_setFontSize cfg, text, w
			y += @_middleTextPos text, fh, cfg.height
		else if cfg.angle is 90
			y += cfg.height - cfg.padding
			w = cfg.height - 2 * cfg.padding
			fh = @_setFontSize cfg, text, w
			x += @_middleTextPos text, fh, cfg.width
			tw = @pdf.getTextWidth text
			y -= switch cfg.align
				when "right" then w - tw
				when "center" then (w - tw)/2
				else 0
			cfg.align = null
		@pdf.text text, x, y, cfg.angle, cfg.align

	box: (x,y,w,h,color) ->
		color = color || [255]
		@pdf.setLineWidth .5
		@pdf.setFillColor.apply null, color
		@pdf.rect x, y, w, h, 'F'
		@pdf.setDrawColor 0, 0, 0
		@pdf.lines [[0,0],[w,0],[0,h],[-w,0],[0,-h]], x, y

module.exports = PDF