Canvas = can.Construct.extend
	_WIDTH  : 800
	_HEIGHT : 500
,
	init : ( id ) ->
		Selection = require 'selection'

		@draw            = SVG("#{id}").size Canvas._WIDTH, Canvas._HEIGHT
		@elements        = {}
		@connections     = []

		@current_element = null
		@target_element  = null

		@selection = new Selection @

		@_addListeners()

	_addListeners : ->
		$("#canvas").on "click", (event) =>
			@clearSelection()

	connectElements : ->
		startPoint =
			x : @current_element.attr('x') + @current_element.attr('width')
			y : Math.round @current_element.attr('y') + @current_element.attr('height') / 2

		endPoint =
			x : @target_element.attr('x')
			y : Math.round @target_element.attr('y') + @target_element.attr('height') / 2

		path = @draw.path "M#{startPoint.x},#{startPoint.y} C #{startPoint.x + 100} #{startPoint.y + 50}, #{endPoint.x - 100} #{endPoint.y - 50}, #{endPoint.x} #{endPoint.y}"
		path.stroke({ width: 2 })
		path.attr 'fill', 'transparent'

		@connections.push
			initial : @current_element.attr 'id'
			final   : @target_element.attr 'id'
			line    : path

		@current_element = null
		@target_element  = null

	clearSelection : ->
		@current_element = null
		@selection.clear()

	select : (element) ->
		@current_element = element
		@selection.update element

module.exports = Canvas