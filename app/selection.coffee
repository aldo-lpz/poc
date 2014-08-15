Selection = can.Construct.extend
	init : ( canvas ) ->
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