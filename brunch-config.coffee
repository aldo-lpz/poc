exports.config =
	files:
		javascripts:
			joinTo:
				'app.js': /^(vendor|bower_components|app)/

			order:
				before: [
					'bower_components/jquery/dist/jquery.js',
					'bower_components/lodash/dist/lodash.js'
				]

		stylesheets:
			joinTo:
				'style.css': /^app\/css/

			before: ['bower_components/normalize-css/normalize.css']

		templates:
			joinTo: 
				'app.js' : /^app\/templates/

	plugins:
		autoReload:
			enabled:
				js: on
				css: on
				assets: on
