console.log "init del poc"

window.app = {}
defs = 
	input :
		message : 'type a message for your input'
		type    : ['number', 'string']

	output :
		message	: 'type a message for your output',
		type    : ['alert', 'message']

	process :
		message : 'describe the process'

	user :
		authenticated : false


Editor = can.Control.extend
	init : ->
		@data = new can.Map
			element : ""

		@element.html can.view 'templates/editor.hbs', @data


$ ->

	editor = new Editor "#properties"

	window.Canvas = require 'core/canvas'
	window.Utils  = require 'core/utils'
	Box           = require 'core/box'

	app.canvas = new Canvas 'canvas'	

	$('.btn-default').on "click", (event) ->
		type = $(@).data 'type'
		b = new Box "#{type}"

		if type is "user"
			app.canvas.initialBox = b

	$('#clearAll').on "click", (event) ->
		app.canvas.clear()

	$('#exec').on "click", (event) ->
		console.log "exec"

	$(app).on "elementSelected", (event) ->
		editor.data.attr 'element', event._data.type

	$(app).on "selectionCleared", (event) ->
		console.log "selectionCleared"











