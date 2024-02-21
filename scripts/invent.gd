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

var onPaper = false
var tool = "none"

@onready var ap = get_parent().get_node("AnimationPlayer")

func _input(_event):
	if(!onPaper):
		return
		
	#draw
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and tool == "pencil"):
		var newPoint = Point.new(get_global_mouse_position(), Color.BLACK)
		points.append(newPoint)
		queue_redraw()
		
	#erase
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and tool == "eraser"):
		var i = 0
		while i < points.size():
			var point = points[i]
			if(point.position.distance_to(get_global_mouse_position()) <= eraseSize):
				points.pop_at(i)
			else:
				i += 1
			queue_redraw()
			
	queue_redraw()

func _draw():
	for point in points:
		draw_circle(point.position, drawSize, point.color)
		
	#indicate eraser radius
	if(tool == "eraser" and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		draw_circle(get_global_mouse_position(), eraseSize, Color.PINK)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_paper_entered():
	onPaper = true

func _on_paper_exited():
	onPaper = false

func _on_pencil_clicked(_viewport, _event, _shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		tool = "pencil"
		ap.play("pencil")

func _on_eraser_clicked(_viewport, _event, _shape_idx):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		tool = "eraser"
		ap.play("eraser")
