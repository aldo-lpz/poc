Box = can.Construct.extend
	init : (type, meta) ->
		@rect    = null
		@id      = null
		@outputs = []
		@inputs  = []
		@type    = type
		@meta    = meta

		@_draw Math.round(Canvas._WIDTH / 2), Math.round(Canvas._HEIGHT / 2), 100, 70, 10

	connectTo : (targetBox) ->
		source = @group.bbox()

		output =
			target  : targetBox
			line    : null

		input =
			source : @
			line   : null

		target   = targetBox.group.bbox()
		path_str = @getConnectionPath source, target		

		path = app.canvas.draw.path path_str
		path.stroke({ width: 2 })
		path.attr 'fill', 'transparent'

		path.marker 'end', 5, 5, (add) ->
			add.rect 5, 5

		output.line = path
		input.line  = path

		targetBox.inputs.push input
		@outputs.push output

	getConnectionPath : (source, target) ->
		# array of posible connnection points
		anchors = [
			x : source.x + Math.round source.width / 2
			y : source.y
		,
			x : source.x + Math.round source.width / 2
			y : source.y + source.height
		,
			x : source.x
			y : source.y + Math.round source.height / 2
		,
			x : source.x + source.width
			y : source.y + Math.round source.height / 2
		,
			x : target.x + Math.round target.width / 2
			y : target.y
		,
			x : target.x + Math.round target.width / 2
			y : target.y + target.height
		,
			x : target.x
			y : target.y + Math.round target.height / 2
		,
			x : target.x + target.width
			y : target.y + Math.round target.height / 2
		]
		d = {}
		distances = []
		i = 0
		while i < 4
			j = 4
			while j < 8
				dx = Math.abs(anchors[i].x - anchors[j].x)
				dy = Math.abs(anchors[i].y - anchors[j].y)
				if (i is j - 4) or (((i isnt 3 and j isnt 6) or anchors[i].x < anchors[j].x) and ((i isnt 2 and j isnt 7) or anchors[i].x > anchors[j].x) and ((i isnt 0 and j isnt 5) or anchors[i].y > anchors[j].y) and ((i isnt 1 and j isnt 4) or anchors[i].y < anchors[j].y))
					distances.push dx + dy
					d[ distances[distances.length - 1] ] = [i, j]
				j++
			i++
		closest = d[Math.min.apply(Math, distances)]

		x1 = anchors[closest[0]].x
		y1 = anchors[closest[0]].y
		x4 = anchors[closest[1]].x
		y4 = anchors[closest[1]].y
		dx = Math.round Math.max Math.abs(x1 - x4) / 2, 10
		dy = Math.round Math.max Math.abs(y1 - y4) / 2, 10
		x2 = [x1, x1, x1 - dx, x1 + dx][closest[0]]
		y2 = [y1 - dy, y1 + dy, y1, y1][closest[0]]
		x3 = [0, 0, 0, 0, x4, x4, x4 - dx, x4 + dx][closest[1]]
		y3 = [0, 0, 0, 0, y1 + dy, y1 - dy, y4, y4][closest[1]]

		return "M#{x1},#{y1} C #{x2} #{y2}, #{x3} #{y3}, #{x4} #{y4}"


	_draw : (x, y, w, h, r) ->
		ref   = @
		@group = app.canvas.draw.group()
		@rect = app.canvas.draw.rect(w, h).radius(r)
		clr   = Utils.get_random_color()
		@rect.fill {color : clr.toHex(), opacity : 0.5}
		@rect.attr
			'x'            : x
			'y'            : y
			"stroke"       : clr.toHex()
			"stroke-width" : 3
			"cursor"       : 'move'

		text = app.canvas.draw.text("#{@type}").attr
			'x'      : Math.round x + w / 2
			'y'      : Math.round y + h / 2
			"cursor" : 'move'

		@group.add @rect
		@group.add text

		@group.on "click", (event) =>
			event.stopPropagation()
			app.canvas.select @

		@group.draggable()
			# minX : 0
			# minY : 0
			# maxX : Canvas._WIDTH
			# maxY : Canvas._HEIGHT

		@group.dragmove = (d, event) ->
			if ref.outputs and ref.outputs.length > 0
				for output in ref.outputs
					output.line.plot ref.getConnectionPath( ref.group.bbox(), output.target.group.bbox() )

			if ref.inputs and ref.inputs.length > 0
				for input in ref.inputs
					input.line.plot ref.getConnectionPath( input.source.group.bbox(), ref.group.bbox() )

		@id = @rect.attr 'id'

		app.canvas.elements[@id] = @

module.exports = Box