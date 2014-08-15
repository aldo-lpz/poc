console.log "init del poc"

window.app = {}

$ ->

	window.Canvas = require 'core/canvas'
	window.Utils  = require 'core/utils'
	Box           = require 'core/box'

	app.canvas = new Canvas 'canvas'	

	r1 = new Box 20, 20, 100, 80, 10
	r2 = new Box 400, 20, 100, 80, 10
	r3 = new Box 300, 200, 100, 80, 10










