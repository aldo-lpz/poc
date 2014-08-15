Canvas = can.Construct.extend
	_WIDTH  : 800
	_HEIGHT : 500
,
	init : ( id ) ->
		Selection = require 'selection'

		@draw            = SVG("#{id}").size Canvas._WIDTH, Canvas._HEIGHT
		@elements        = {}
		@current_element = null
		@target_element  = null

		@selection = new Selection @

		@_addListeners()

	_addListeners : ->
		$("#canvas").on "click", (event) =>
			@clearSelection()

	connectElements : ->
		console.log "ready to connectElements :)"

	clearSelection : ->
		@current_element = null
		@selection.clear()

	select : (element) ->
		@current_element = element
		@selection.update element

module.exports = Canvas