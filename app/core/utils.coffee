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