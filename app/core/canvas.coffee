Canvas = can.Construct.extend
	_WIDTH  : 800
	_HEIGHT : 500
,
	init : ( id ) ->
		Selection = require 'core/selection'

		@draw            = SVG("#{id}").size Canvas._WIDTH, Canvas._HEIGHT
		@elements        = {}
		@current_element = null

		@selection = new Selection @

		@_addListeners()

	_addListeners : ->
		$("#canvas").on "click", (event) =>
			@clearSelection()

	clearSelection : ->
		@selection.clear()

	select : (element) ->
		@current_element = element
		@selection.update element

module.exports = Canvas