Canvas = can.Construct.extend
	_WIDTH  : 800
	_HEIGHT : 500
,
	init : ( id ) ->
		Selection = require 'selection'

		@draw = SVG("#{id}").size Canvas._WIDTH, Canvas._HEIGHT
		@elements  = {}

		@selection = new Selection @

		@_addListeners()

	_addListeners : ->
		$("#canvas").on "click", (event) =>
			@clearSelection()

	clearSelection : ->
		console.log "clearign selection"
		@selection.clear()

	select : (element) ->
		@selection.update element

module.exports = Canvas