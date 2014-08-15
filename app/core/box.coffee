Box = can.Construct.extend
	init : (x, y, w, h, r) ->
		@rect        = null
		@id          = null
		@connections = []

		@_draw x, y, w, h, r

	connectTo : (targetBox) ->
		source = @rect.bbox()

		conn =
			target  : targetBox
			line    : null

		target   = targetBox.rect.bbox()
		path_str = @getConnectionPath source, target		

		path = app.canvas.draw.path path_str
		path.stroke({ width: 2 })
		path.attr 'fill', 'transparent'

		conn.line = path

		@connections.push conn

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
		# get the closest points
		d = {}
		distances = []
		i = 0
		while i < 4
			j = 4
			while j < 8
				dx = Math.abs(anchors[i].x - anchors[j].x)
				dy = Math.abs(anchors[i].y - anchors[j].y)
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
		@rect = app.canvas.draw.rect(w, h).radius(r)
		clr   = Utils.get_random_color()
		@rect.fill {color : clr.toHex(), opacity : 0.5}
		@rect.attr
			'x'            : x
			'y'            : y
			"stroke"       : clr.toHex()
			"stroke-width" : 3

		@rect.on "click", (event) ->
			event.stopPropagation()
			app.canvas.select ref

		@rect.draggable
			minX : 0
			minY : 0
			maxX : Canvas._WIDTH
			maxY : Canvas._HEIGHT

		@rect.dragmove = (d, event) ->
			if ref.connections.length > 0
				for c in ref.connections
					c.line.plot ref.getConnectionPath(ref.rect.bbox(), c.target.rect.bbox())

		@id = @rect.attr 'id'

		app.canvas.elements[@id] = @

module.exports = Box