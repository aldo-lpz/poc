console.log "init del poc"


$ ->
	CANVAS_WIDTH  = 800
	CANVAS_HEIGHT = 500

	draw = SVG('canvas').size(CANVAS_WIDTH, CANVAS_HEIGHT)

	get_random_color = ->
		color_str = [ 
			Math.round(255 * Math.random()), 
			Math.round(255 * Math.random()), 
			Math.round(255 * Math.random()) 
		].join(",")
		return new SVG.Color "rgb(#{color_str})"

	draw_rect = (x, y, w, h, r) ->
		rect = draw.rect(w, h).radius(r)
		clr  = get_random_color()
		rect.fill {color : clr.toHex(), opacity : 0.5}
		rect.attr
			'x'            : x
			'y'            : y
			"stroke"       : clr.toHex()
			"stroke-width" : 3

		rect.draggable
			minX : 0
			minY : 0
			maxX : CANVAS_WIDTH
			maxY : CANVAS_HEIGHT

		return rect

	for i in [1..10] by 1
		draw_rect Math.round(600 * Math.random()), Math.round(400 * Math.random()), Math.round(200 * Math.random()), Math.round(200 * Math.random()), Math.round(10 * Math.random())
		

		# handler = draw.rect 10, 10
		# handler.attr
		# 	'x'            : x + (w / 2) - 5
		# 	'y'            : y + (h / 2) - 5
		# 	'fill'         : '#fff'
		# 	"stroke"       : '#000'
		# 	"stroke-width" : 1

		# group = draw.group()
		# group.add rect
		# group.add handler

		# rect.draggable()

		# initial_pos = 
		# 	x : 0
		# 	y : 0

		# handler.draggable()
		# handler.beforestart = (event) ->
		# 	group.fixed()

		# handler.dragstart = (delta, event) ->
		# 	initial_pos =
		# 		x : delta.x
		# 		y : delta.y

		# handler.dragend = (event) ->
		# 	group.draggable()
		# 	handler.attr
		# 		'x' : initial_pos.x
		# 		'y' : initial_pos.y		


	r1 = draw_rect 20, 20, 100, 100, 10
	r2 = draw_rect 400, 20, 150, 100, 10



# S4 = () ->
# 	(((1 + Math.random()) * "0x10000") | 0).toString(16).substring 1

# guid = () ->
# 	S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4()

# $(document).ready ->

# 	DRAGGING = false

# 	CANVAS_WIDTH  = 800
# 	CANVAS_HEIGHT = 500

# 	$canvas = $ '#canvas'

# 	paper = Raphael document.getElementById("canvas"), CANVAS_WIDTH, CANVAS_HEIGHT

# 	Raphael.st.draggable = () ->
# 		ref = @
# 		ox = 0
# 		oy = 0
# 		lx = 0
# 		ly = 0
# 		moveFnc = (dx, dy, x, y, evt) ->
# 			if x > 0 and x < CANVAS_WIDTH and y > 0 and y < CANVAS_HEIGHT
# 				lx = dx + ox
# 				ly = dy + oy
# 				ref.transform "t" + lx + "," + ly
# 		startFnc = (x, y, evt) ->
# 		endFnc = (evt) ->
# 			ox = lx
# 			oy = ly

# 		@drag moveFnc, startFnc, endFnc

# 	draw_rect = (x, y, w, h, r) =>
# 		rect = paper.rect.apply paper, arguments
# 		fill_color = [ 255 * Math.random(), 255 * Math.random(), 255 * Math.random() ].join(",")
# 		rect.attr
# 			"fill"         : "rgba(#{fill_color}, 0.5)"
# 			"stroke"       : "rgb(#{fill_color})"
# 			"stroke-width" : 3
# 			"cursor"       : "move"

# 		handler = draw_handler rect

# 		$(rect[0]).on "draginit", (event, drag) ->
# 			handler.hide()
		
# 		$(rect[0]).on "dragmove", (event, drag) ->
# 			if x > 0 and x < CANVAS_WIDTH and y > 0 and y < CANVAS_HEIGHT
# 				rect.attr
# 					"x" : drag.location.x()
# 					"y" : drag.location.y()

# 		$(rect[0]).on "dragend", (event, drag) ->
# 			update_handler_position handler, rect
# 			handler.show()

# 		$(rect[0]).on "mouseenter", { ref : handler, container : rect }, (event) ->
# 			update_handler_position event.data.ref, event.data.container
# 			event.stopPropagation()
# 			event.data.ref.show() if not DRAGGING

# 		$(rect[0]).on "mouseleave", { ref : handler, container : rect }, (event) ->
# 			event.stopPropagation()
# 			unless Raphael.isPointInsideBBox(event.data.container.getBBox(), event.offsetX, event.offsetY)
# 				event.data.ref.hide() if not DRAGGING

# 		# moveFnc = (dx, dy, x, y, evt) ->
# 		# 	if x > 0 and x < CANVAS_WIDTH and y > 0 and y < CANVAS_HEIGHT
# 		# 		@attr
# 		# 			"x" : @orig_pos.x + dx
# 		# 			"y" : @orig_pos.y + dy
				
# 		# startFnc = (x, y, evt) ->
# 		# 	@orig_pos =
# 		# 		x : @attr "x"
# 		# 		y : @attr "y"

# 		# endFnc = (evt) ->

# 		# rect.drag moveFnc, startFnc, endFnc

# 		rect

# 	draw_handler = (container) ->
# 		x = container.attr "x"
# 		y = container.attr "y"
# 		w = container.attr "width"
# 		h = container.attr "height"
# 		handler = paper.rect x + (w / 2) - 5, y + (h / 2) - 5, 10, 10
# 		handler.attr
# 			"fill"         : "#fff"
# 			"stroke-width" : 1

# 		orig_pos =
# 			x : 0
# 			y : 0

# 		$(handler[0]).on "draginit", (event, drag) ->
# 			orig_pos.x = handler.attr "x"
# 			orig_pos.y = handler.attr "y"
		
# 		$(handler[0]).on "dragmove", (event, drag) ->
# 			DRAGGING = true
# 			if x > 0 and x < CANVAS_WIDTH and y > 0 and y < CANVAS_HEIGHT
# 				handler.attr
# 					"x" : drag.location.x()
# 					"y" : drag.location.y()

# 		$(handler[0]).on "dragend", (event, drag) ->
# 			DRAGGING = false
# 			handler.attr
# 				"x" : orig_pos.x
# 				"y" : orig_pos.y

# 		handler.hide()
# 		handler

# 	update_handler_position = (handler, container) ->
# 		x = container.attr "x"
# 		y = container.attr "y"
# 		w = container.attr "width"
# 		h = container.attr "height"
# 		handler.attr
# 			"x" : x + (w / 2) - 5
# 			"y" : y + (h / 2) - 5

	
# 	r1 = draw_rect 20, 20, 100, 100, 10
# 	r2 = draw_rect 400, 20, 150, 100, 10

# 	handler1 = draw_handler r1
# 	handler2 = draw_handler r2

# 	# r1.mouseover (evt) ->
# 	# 	update_handler_position handler1, @
# 	# 	handler1.show()

# 	# r1.mouseout () ->
# 	# 	handler1.hide()

# 	# r2.mouseover () ->
# 	# 	update_handler_position handler2, @
# 	# 	handler2.show()

# 	# r2.mouseout () ->
# 	# 	handler2.hide()

# 	# $canvas.on "mousedown", (event) ->
# 	# 	event.stopPropagation()		
# 	# 	start_point =
# 	# 		x : event.offsetX
# 	# 		y : event.offsetY

# 	# 	end_point = 
# 	# 		x : 0
# 	# 		y : 0

# 	# 	path_str = "M#{start_point.x}, #{start_point.y}"
# 	# 	line = paper.path path_str

# 	# 	$(@).on "mousemove", (event) ->			
# 	# 		curr_position =
# 	# 			x : event.offsetX
# 	# 			y : event.offsetY

# 	# 		diff =
# 	# 			x : curr_position.x - start_point.x
# 	# 			y : curr_position.y - start_point.y

# 	# 		console.log "moviendose", diff.x, diff.y

# 	# 		end_point =
# 	# 			x : start_point.x + diff.x
# 	# 			y : start_point.y + diff.y

# 	# 		if diff.x > 50 or diff.y > 50
# 	# 			path_str += "L#{end_point.x}, #{end_point.y}"
# 	# 			line.attr "path", path_str

# 	# 	$(@).on "mouseup", (event) ->
# 	# 		console.log "dejo de moverse"

# 	# 		path_str += "L#{end_point.x}, #{end_point.y}"
# 	# 		line.attr "path", path_str
			
# 	# 		$(@).off "mouseup"
# 	# 		$(@).off "mousemove"








