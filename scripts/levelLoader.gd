extends Sprite2D

@export var level = "draw"
@export var sprite = "res://assets/UI/arrow.png"
@export var displayText = "text"

@onready var sceneManager = get_tree().get_root().get_node("game/sceneManager")
@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")
@onready var text = get_node("RichTextLabel")

@onready var newName = get_parent().get_node("UI/name")
@onready var feature1 = get_parent().get_node("UI/feature1")
@onready var feature2 = get_parent().get_node("UI/feature2")
@onready var tag1 = get_parent().get_node("UI/tag1")
@onready var tag2 = get_parent().get_node("UI/tag2")
@onready var tag3 = get_parent().get_node("UI/tag3")

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
		inventionManager.setData(newName.text, feature1.text, feature2.text, tag1.text, tag2.text, tag3.text)
		sceneManager.loadLevel(level)
