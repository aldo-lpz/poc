console.log "init del poc"

window.app = {}

$ ->

	Canvas = require 'core/canvas'
	Utils  = require 'core/utils'

	app.canvas = new Canvas 'canvas'

	draw_rect = (x, y, w, h, r) ->
		rect = app.canvas.draw.rect(w, h).radius(r)
		clr  = Utils.get_random_color()
		rect.fill {color : clr.toHex(), opacity : 0.5}
		rect.attr
			'x'            : x
			'y'            : y
			"stroke"       : clr.toHex()
			"stroke-width" : 3

		rect.on "click", (event) ->
			event.stopPropagation()
			app.canvas.select @

		rect.draggable
			minX : 0
			minY : 0
			maxX : Canvas._WIDTH
			maxY : Canvas._HEIGHT

		return rect


	r1 = draw_rect 20, 20, 100, 80, 10
	r2 = draw_rect 400, 20, 100, 80, 10

	app.canvas.elements[r1.attr('id')] = r1
	app.canvas.elements[r2.attr('id')] = r2










