extends Node2D

class Point:
	var position: Vector2
	var color: Color
	
	func _init(pos: Vector2, col: Color):
		position = pos
		color = col
	
var points = []

var drawSize = 10
var eraseSize = 20

@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")

func _ready():
	points = inventionManager.sendDrawing()
	
func _process(_delta):
	queue_redraw()
	
func _draw():
	var scalar = .80
	for point in points:
		#i could have done some linear algebra but NO
		var tmpPos = point.position * scalar
		tmpPos.x -= 150
		tmpPos.y -= 5
		draw_circle(tmpPos, drawSize * scalar, point.color)
