_ = require 'underscore'
dateFormat = require('date-fns/format')

class PDFCard
	cfg: null

	constructor: (cfg, @pdf, @helfer) ->
		@cfg = cfg.card
		do @helfer.prepare
	setPage: (@pageNo) ->
	setXY: (@offsetX, @offsetY) ->

	_getColor: (name) -> switch name
		when "red" then [255, 230, 230]
		when "yellow" then [255, 255, 230]
		when "green" then [230, 255, 230]
		when "attention" then [230, 230, 255]
		else [255, 255, 255]
	
	_bigBox: (cfg, text, color) ->
		@pdf.box @offsetX, @offsetY, cfg.width, cfg.height, color
		@pdf.fitText cfg, @offsetX, @offsetY, text
		@offsetY += cfg.height
	
	_imageBox: (cfg, color) ->
		@pdf.box @offsetX, @offsetY, @cfg.width, cfg.height, color
		x = (@cfg.width - cfg.width) / 2
		@pdf.box @offsetX + x, @offsetY, cfg.width, cfg.height, [255]
		@offsetY += cfg.height
	
	_wideBox: (cfg, text, color) ->
		@pdf.box @offsetX, @offsetY, cfg.width, cfg.height, color
		@pdf.fitText cfg, @offsetX, @offsetY, text
		@offsetY += cfg.height
	
	_putAusbildung: ->
		ausb = @helfer.get 'Ausbildung'
		cfg = @cfg.box.ausb
		cfg.padding = 1
		x = @offsetX
		y = @offsetY
		if ausb.order.length < 2
			w = 18
			@pdf.box x, y, w, cfg.height
			cfg2 = Object.assign {}, cfg, width:w
			@pdf.fitText cfg2, x, @offsetY, "Ausb.:"
			x += w
			w2 = 13
			@pdf.box x, y, cfg.width - w, cfg.height
			if ausb.order.length
				cfg2 = Object.assign {}, cfg, align:"right", width:w2
				@pdf.fitText cfg2, x, y, ausb[ausb.order[0]].topic + ':'
				cfg2 = Object.assign {}, cfg, width:cfg.width - w - w2
				@pdf.fitText cfg2, x + w2, y, ausb[ausb.order[0]].text
			y += cfg.height
		else
			w = 10
			@pdf.box x, y, w, ausb.order.length * cfg.height
			cfg2 = Object.assign {}, cfg, width:w, align: "center", angle:90, fontSize:16, height: ausb.order.length*cfg.height
			if ausb.order.length is 2
				@pdf.fitText cfg2, @offsetX, @offsetY, "Ausb."
			else
				@pdf.fitText cfg2, @offsetX, @offsetY, "Ausbild."
			x += w
			w2 = 13
			for o in ausb.order
				@pdf.box x, y, cfg.width - w, cfg.height
				cfg2 = Object.assign {}, cfg, align:"right", width:w2
				@pdf.fitText cfg2, x, y, ausb[o].topic + ':'
				cfg2 = Object.assign {}, cfg, width:cfg.width - w - w2
				@pdf.fitText cfg2, x + w2, y, ausb[o].text
				y += cfg.height
		@offsetY = y

	_putBerechtigungen: ->
		ber = @helfer.get 'Berechtigungen'
		cfg = @cfg.box.ber
		# determine length
		len = {}
		for o in ber.order
			fs = @pdf.calcFontSize cfg, ber[o].text, cfg.width/2 - 2*cfg.padding
			len[o] = if fs < cfg.fontSize[0] then 'wide' else 'small'
		letCb = _.countBy len, (v) -> v

		# move last small to end
		if ber.order[ber.order.length - 1] isnt 'small' and letCb['small'] %% 2 is 1
			for i in [ber.order.length-1 .. 0]
				if len[ber.order[i]] is 'small'
					x = ber.order.splice i, 1
					ber.order.push x[0]
					break
		# move longer before modsml
		smlNum = 0
		for i in [0 ... ber.order.length]
			if smlNum %% 2 and len[ber.order[i]] is 'wide'
				x = ber.order.splice i, 1
				ber.order.splice i-1, 0, x[0]
			else if len[ber.order[i]] is 'small'
				smlNum++

		smlNum = 0
		for b in ber.order
			cfg2 = Object.assign {}, cfg
			x = @offsetX
			if len[b] is 'small'
				cfg2.width /= 2 
				x += if smlNum %% 2 then cfg2.width else 0
			color = @_getColor ber[b].color

			@pdf.box x, @offsetY, cfg2.width, cfg.height, color
			@pdf.fitText cfg2, x, @offsetY, ber[b].text

			@offsetY += cfg.height if smlNum %% 2 or len[b] isnt 'small'
			smlNum++ if len[b] is 'small' 
		@offsetY += cfg.height if smlNum %% 2

	_putFail: (b, fails) ->
		cfg = @cfg.box.fail
		for f,i in fails
			if i is 0
				p = "#{b}: "
				w = 0
			else
				p = ""
				w = @pdf.getTextWidth cfg, "#{b}: "

			@pdf.fitText cfg, @offsetX + w, @offsetY, p + switch f.level
				when 1 then "#{f.err} bis " + dateFormat f.date, "DD.MM.YY"
				when 2,3 then "#{f.err} abgelaufen " + dateFormat f.date, "(MM/YY)"
				when 4,5 then "#{f.err} fehlt"
			@offsetY += cfg.height

	_putFails: ->
		@offsetY += @cfg.box.fail.height / 2
		ber = @helfer.get 'Berechtigungen'
		@_putFail "EB", @helfer.get('EB').fails
		@_putFail b, ber[b].fails for b in ber.order
		
	_putBase: ->
		name = @helfer.get('Vorname') + ' ' + @helfer.get('Name')
		fkt = @helfer.get('Titel')
		ebDisplay = @helfer.get('EB')
		bg = @_getColor ebDisplay.color
		
		@_bigBox @cfg.box.function, fkt, bg 
		@_imageBox @cfg.box.picture, bg
		@_bigBox @cfg.box.name, name, bg 
		@_wideBox @cfg.box.eb, ebDisplay.text, bg
	
	print: ->
		do @_putBase
		do @_putAusbildung
		do @_putBerechtigungen
		do @_putFails

module.exports = PDFCard