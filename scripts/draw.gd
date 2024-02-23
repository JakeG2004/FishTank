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

var isProcessed = false

var oldPos

@onready var ap = get_parent().get_node("AnimationPlayer")
@onready var audio = get_parent().get_node("AudioStreamPlayer")
@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")
@onready var confirmcard = get_parent().get_node("confirmcard")

@onready var scribble = preload("res://assets/audio/sfx/scribble-6144.mp3")
@onready var erase = preload("res://assets/audio/sfx/erasing.mp3")

func _ready():
	points = inventionManager.sendDrawing()
	
func _input(_event):
	if(!onPaper):
		return
	#draw
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and tool == "pencil"):
		#handle audio
		if(!audio.playing):
			audio.stream = scribble
			audio.play(0)
			
		#actually draw
		var newPoint = Point.new(get_global_mouse_position(), Color.BLACK)
		points.append(newPoint)
		queue_redraw()
		
	#erase
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and tool == "eraser"):
		var i = 0
		
		#handle audio
		if(!audio.playing):
			audio.stream = erase
			audio.play(0)
			
		#actually erase
		while i < points.size():
			var point = points[i]
			if(point.position.distance_to(get_global_mouse_position()) <= eraseSize):
				points.pop_at(i)
			else:
				i += 1
			queue_redraw()
			
	#additional draw to get rid of eraser circle
	queue_redraw()

func _process(_delta):
	if(Input.is_action_just_released("click")):
		isProcessed = false
		audio.stop()
		
	if(oldPos == get_viewport().get_mouse_position()):
		if(!ap.is_playing()):
			audio.stop()
		
	oldPos = get_viewport().get_mouse_position()

func _draw():
	for point in points:
		draw_circle(point.position, drawSize, point.color)
		
	#indicate eraser radius
	if(tool == "eraser" and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		draw_circle(get_global_mouse_position(), eraseSize, Color.PINK)

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

func _on_approve_clicked(_viewport, _event, _shape_idx):
	#send drawing to drawingManager
	tool = "none"
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and !isProcessed):
		isProcessed = true
		inventionManager.getDrawing(points)
		confirmcard.toggle()

