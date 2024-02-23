extends Sprite2D

@export var level = "draw"
@export var sprite = "res://assets/UI/arrow.png"
@export var displayText = "text"

@onready var sceneManager = get_tree().get_root().get_node("game/sceneManager")
@onready var text = get_node("RichTextLabel")

var isProcessed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = displayText
	texture = load(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_released("click")):
		isProcessed = false


func _on_click(_viewport, _event, _shape_idx):
	if(isProcessed):
		return
		
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		sceneManager.loadLevel(level)
