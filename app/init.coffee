console.log "init del poc"

window.app = {}

$ ->

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









