extends Node2D

@onready var description = get_node("card/description")
@onready var toggle = get_node("card/hide/hidetext")
@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")
@onready var ap = get_node("AnimationPlayer")

var prompt
var isUp = false
var isProcessed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	prompt = inventionManager.problem
	description.text = "[center]{}[/center]".format([prompt], "{}")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_released("click")):
		isProcessed = false


func _on_hide_clicked(_viewport, _event, _shape_idx):
	#hide  / show
	if(isProcessed):
		return
		
	if(!Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		return
		
	isProcessed = true
		
	if(isUp):
		ap.play("drop")
		isUp = false
		
	elif(!isUp):
		ap.play("fishup")
		isUp = true
