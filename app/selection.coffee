Selection = can.Construct.extend
	init : ( canvas ) ->
		@isTryingToConnect = false

		@canvas = canvas
		@helper = @canvas.draw.group()

		@wrapper = @canvas.draw.rect(100, 100)
		@wrapper.fill { color : '', opacity : 0 }
		@wrapper.stroke 'blue'
		@wrapper.attr
			"stroke-dasharray" : "5,5"

		@in_handler = @canvas.draw.rect(10, 10)
		@in_handler.fill { color : '#fff', opacity : 1 }
		@in_handler.stroke 'blue'

		@out_handler = @canvas.draw.rect(10, 10)
		@out_handler.fill { color : '#fff', opacity : 1 }
		@out_handler.stroke 'blue'

		@helper.add @wrapper
		@helper.add @in_handler
		@helper.add @out_handler

		@helper.hide()

		@_addListeners()

	_addListeners : ->		
		ref = @
		
		@out_handler.on "mousedown", (event) ->
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
					continue if k is app.canvas.current_element.attr "id"

					if el.inside end_point.x, end_point.y
						app.canvas.target_element = el
						app.canvas.connectElements()

				ref.isTryingToConnect = false

				$('#canvas').off "mouseup"
				$('#canvas').off "mousemove"

	clear: ->
		@helper.hide()

	update : (element) ->
		bounds = element.bbox()
		@wrapper.move bounds.x - 10, bounds.y - 10
		@wrapper.size bounds.width + 20, bounds.height + 20

		@in_handler.move bounds.x - 15, bounds.y + Math.round(bounds.height / 2)
		@out_handler.move bounds.x + bounds.width + 5 , bounds.y + Math.round(bounds.height / 2)
		
		@helper.show()

module.exports = Selection