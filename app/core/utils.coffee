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

Utils = can.Construct.extend

	get_random_color : ->
		color_str = [ 
			Math.round(255 * Math.random()), 
			Math.round(255 * Math.random()), 
			Math.round(255 * Math.random()) 
		].join(",")
		return new SVG.Color "rgb(#{color_str})"

, {}

module.exports  = Utils