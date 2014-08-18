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

	show : ->
		@element.show()

	hide : ->
		@element.hide()

	setValues : (type, meta) ->
		@data.attr 'element', type
		for key, option of meta
			@data.values.attr "#{key}", option

	clearValues : ->
		@data.attr 'element', ''
		@data.attr 'values.message', ''
		@data.attr 'values.type', ''
		@data.attr 'values.authenticated', false

module.exports = Editor