Selection = can.Construct.extend
	init : ( canvas ) ->
		@isTryingToConnect = false

		@canvas = canvas

		@createWrapper()
		@_addListeners()

	createWrapper : ->
		@helper = @canvas.draw.group()

		@wrapper = @canvas.draw.rect(100, 100)
		@wrapper.fill { color : 'transparent', opacity : 0 }
		@wrapper.stroke 'blue'
		@wrapper.attr
			"stroke-dasharray" : "5,5"

		@handler = @canvas.draw.rect(10, 10)
		@handler.fill { color : '#fff', opacity : 1 }
		@handler.stroke 'blue'

		@helper.add @wrapper
		@helper.add @handler

		@helper.hide()

	_addListeners : ->		
		ref = @
		
		@handler.on "mousedown", (event) ->
			event.stopPropagation()
			line = null
			start_point =
				x : @attr('x') + 5
				y : @attr('y') + 5

			end_point = 
				x : 0
				y : 0

			line = ref.canvas.draw.line(start_point.x, start_point.y, start_point.x, start_point.y).stroke({ width: 2 })

			ref.isTryingToConnect = true

			$('#canvas').on "mousemove", (event) ->		
				event.stopPropagation()	
				curr_position =
					x : event.offsetX
					y : event.offsetY

				diff =
					x : Math.round curr_position.x - start_point.x
					y : Math.round curr_position.y - start_point.y

				end_point =
					x : start_point.x + diff.x
					y : start_point.y + diff.y
				
				line.plot(start_point.x, start_point.y, end_point.x, end_point.y)

			$('#canvas').on "mouseup", (event) ->
				event.stopPropagation()				
				line.remove()
				
				for k, el of app.canvas.elements
					continue if k is app.canvas.current_element.id

					if el.group.inside end_point.x, end_point.y
						app.canvas.current_element.connectTo el
						ref.clear()

				ref.isTryingToConnect = false

				$('#canvas').off "mouseup"
				$('#canvas').off "mousemove"

	clear: ->
		@helper.hide()

	update : (element) ->
		bounds = element.group.bbox()
		@wrapper.move bounds.x - 10, bounds.y - 10
		@wrapper.size bounds.width + 20, bounds.height + 20

		@handler.move bounds.x + Math.round(bounds.width / 2 - 5) , bounds.y + Math.round(bounds.height / 2 - 5)
		
		@helper.show()
		@helper.front()

module.exports = Selection