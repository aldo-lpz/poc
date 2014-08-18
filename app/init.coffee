console.log "init del poc"

window.app = 
	user : 
		authenticated : true

$ ->
	exec_json = {}

	window.Canvas = require 'core/canvas'
	window.Utils  = require 'core/utils'
	Box           = require 'core/box'
	Editor        = require 'core/editor'
	Engine        = require 'core/engine'

	app.editor = new Editor "#properties"
	app.engine = new Engine '#engine'
	app.canvas = new Canvas 'canvas'

	$('.add_button').on "click", (event) ->
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
		exec_json.startPoint = 
			type : app.canvas.initialBox.type
			meta : app.canvas.initialBox.meta
		
		exec_json.steps = []
		
		getOutputs = (element) ->
			for output in element.outputs
				exec_json.steps.push 
					type : output.target.type
					meta : output.target.meta
				
				if output.target.outputs and output.target.outputs.length > 0
					getOutputs output.target

		getOutputs app.canvas.initialBox
		app.editor.hide()
		app.engine.exec exec_json

	$(app).on "elementSelected", (event) ->
		app.editor.setValues app.canvas.current_element.type, app.canvas.current_element.meta

	$(app).on "selectionCleared", (event) ->
		app.editor.clearValues()











