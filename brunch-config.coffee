exports.config =
	files:
		javascripts:
			joinTo:
				'app.js': /^(vendor|bower_components|app)/

			order:
				before: [
					'bower_components/jquery/dist/jquery.js',
					'bower_components/lodash/dist/lodash.js',
					'bower_components/svg.js/dist/svg.js'
				]

		stylesheets:
			joinTo:
				'style.css': /^(bower_components|app\/css)/
			order:
				before : [
					'bower_components/bootstrap/dist/css/bootstrap.css',
					'bower_components/bootstrap/dist/css/bootstrap-theme.css'
				]

				after : ['app/css/app.styl']

		templates:
			joinTo: 
				'app.js' : /^app\/templates/

	plugins:
		autoReload:
			enabled:
				js: on
				css: on
				assets: on
