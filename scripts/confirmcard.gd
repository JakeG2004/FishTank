extends Node2D
#CONFIRMCARD

@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")
@onready var sceneManager = get_tree().get_root().get_node("game/sceneManager")

@onready var ap = get_node("AnimationPlayer")


var isUp = false
var isProcessed = false

func _process(_delta):
	if(Input.is_action_just_released("click")):
		isProcessed = false

func toggle():		
	if(isUp):
		ap.play("hide")
		isUp = false
		
	elif(!isUp):
		ap.play("show")
		isUp = true


func _on_confirm(_viewport, _event, _shape_idx):
	if(isProcessed || !(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT))):
		return
	
	isProcessed = true
	
	sceneManager.loadLevel("test")


func _on_deny(_viewport, _event, _shape_idx):
	if(isProcessed || !(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT))):
		return

	isProcessed = true
	
	toggle()
