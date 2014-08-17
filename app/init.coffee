console.log "init del poc"

window.app = {}

can.Mustache.registerHelper "compare", ( arg1, op, arg2, options ) ->
	operators =
		'==' : (l, r) -> l is r
		'!=' : (l, r) -> l isnt r
		'<'  : (l, r) -> l < r
		'>'  : (l, r) -> l > r
		'<=' : (l, r) -> l <= r
		'>=' : (l, r) -> l >= r
	## fix temporal arg1 lo hago funcion por que es un compute de can js
	if operators[op](arg1(), arg2)
		return options.fn options.contexts or @
	else
		return options.inverse options.contexts or @

Editor = can.Control.extend
	init : ->
		@data = new can.Map
			element : ""
			defs :
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

			values :
				message : ''
				type : ''
				authenticated : false

		
		@element.html can.view 'templates/editor.hbs', @data

		@data.values.bind 'change', (evt, attr, how, newVal, oldVal) =>
			if app.canvas.current_element
				app.canvas.current_element.meta[attr] = newVal

	setValues : (type, meta) ->
		@data.attr 'element', type
		for key, option of meta
			@data.values.attr "#{key}", option

	clearValues : ->
		@data.attr 'element', ''
		@data.attr 'values.message', ''
		@data.attr 'values.type', ''
		@data.attr 'values.authenticated', false


$ ->
	editor = new Editor "#properties"

	window.Canvas = require 'core/canvas'
	window.Utils  = require 'core/utils'
	Box           = require 'core/box'

	app.canvas = new Canvas 'canvas'	

	$('.btn-default').on "click", (event) ->
		type = $(@).data 'type'
		meta = {}
		switch type
			when 'input', 'output' then meta = { message : '', type : '' }
			when 'process' then meta = { message : '' }
			when 'user' then meta = { authenticated : false }
		
		b = new Box "#{type}", meta

		if type is "user"
			app.canvas.initialBox = b

	$('#clearAll').on "click", (event) ->
		app.canvas.clear()

	$('#exec').on "click", (event) ->
		console.log "exec"

	$(app).on "elementSelected", (event) ->
		editor.setValues app.canvas.current_element.type, app.canvas.current_element.meta

	$(app).on "selectionCleared", (event) ->
		editor.clearValues()











