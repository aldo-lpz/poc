Engine = can.Control.extend
	init : ->
		@data = new can.Map
			status : "executing code"
			info   : ""

		@element.html can.view 'templates/engine.hbs', @data

	exec : (json) ->
		@show()
		@data.attr "status", "executing code"

		$inputArea   = @element.find '.inputArea'
		$outputArea  = @element.find '.outputArea'
		$inputArea.empty()
		$outputArea.empty()

		startPoint = json.startPoint

		if startPoint.type is 'user'
			if startPoint.meta.authenticated
				if app.user.authenticated
					@data.attr 'info', 'user is authenticated'
				else
					@data.attr 'info', 'user needs authentication'
					return
		
		inputsCount  = 0
		outputsCount = 0
		processCount = 0
		@inputs      = {}
		@outputs     = {}
		@process     = {}

		prevStep = ''	

		for step in json.steps			
			switch step.type
				when 'input'
					@inputs["input_#{inputsCount}"] = if step.meta.type is 'number' then 0 else ''
					obj =
						message : step.meta.message
						type    : step.meta.type
						id      : "input_#{inputsCount}"

					$inputArea.append can.view 'templates/input.hbs', obj
					inputsCount++

				when 'output'
					if inputsCount isnt 0 and (prevStep is 'input' or prevStep is 'process')
						if prevStep is 'process'
							ref = "process_#{processCount - 1}"
						else
							ref = "input_#{inputsCount - 1}"

						@outputs["output_#{outputsCount}"] =
							type      : step.meta.type
							message   : step.meta.message
							reference : ref
					else
						if step.meta.type is 'alert'
							alert "#{step.meta.message}"
						else
							obj =
								message : step.meta.message
								level   : 'info'

							$outputArea.append can.view 'templates/output.hbs', obj

					outputsCount++

				when 'process'
					if inputsCount isnt 0 and prevStep is 'input'
						ref = "input_#{inputsCount - 1}"

						@process["process_#{processCount}"] =
							message   : step.meta.message
							reference : ref
					else
						obj =
							message : 'this process needs an input'
							level   : 'danger'

						$outputArea.append can.view 'templates/output.hbs', obj

					processCount++

			prevStep = step.type


		ref = @
		@element.undelegate '.generatedInput', 'keyup'
		@element.delegate '.generatedInput', 'keyup', (event) ->
			event.stopPropagation()
			if event.which is 13
				id      = $(@).data 'input-id'
				type    = $(@).data 'input-type'
				val     = $(@).val().trim()
				isValid = true

				if type is 'number' and not $.isNumeric val
					isValid = false
					$outputArea.html can.view 'templates/output.hbs', { message : "#{val} is not a number", level : 'danger' }

				if isValid
					output = _.find ref.outputs, { reference : id }
					if output
						if output.type is 'alert'
							alert "#{output.message}"
						else
							obj =
								message : output.message.replace '{i}', val
								level   : 'info'

							$outputArea.append can.view 'templates/output.hbs', obj

					else
						process = _.find ref.process, { reference : id }
						if process
							result = val * val
							msg = process.message.replace('{i}', val).replace('{r}', result)
							obj =
								message : msg
								level   : 'success'

							$outputArea.append can.view 'templates/output.hbs', obj

	show : ->
		@element.show()

	hide : ->
		@element.hide()

	'#end_process click' : () ->
		@data.attr "status", "end"
		@hide()
		app.editor.show()

module.exports = Engine