extends Node2D

@onready var initMenu = get_node("initMenu")
@onready var attackMenu = get_node("attackMenu")
@onready var dodgeText = get_node("dodgeText")

@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")
@onready var player = get_parent().get_node("player")
@onready var enemy = get_parent().get_node("enemy")

var isProcessed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initMenu.position = Vector2(0, 0)
	attackMenu.position = Vector2(1000, 1000)
	dodgeText.position = Vector2(1000, 1000)
	
	attackMenu.get_node("attack1/text").text = inventionManager.feature1
	attackMenu.get_node("attack2/text").text = inventionManager.feature2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print(isProcessed)
	if(Input.is_action_just_released("click")):
		isProcessed = false

func _on_attackmenu_clicked(_viewport, _event, _shape_idx):
	if(isProcessed):
		return
		
	if(Input.is_action_just_pressed("click")):
		isProcessed = true
		initMenu.position = Vector2(1000, 1000)
		attackMenu.position = Vector2(0, 0)

func _on_dodge_clicked(_viewport, _event, _shape_idx):
	#if(isProcessed):
	#	return
		
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		isProcessed = true
		initMenu.position = Vector2(1000, 1000)
		
		dodgeText.get_node("text").text = "Dodge failed!"
		
		if(randi_range(0, 1) == 1):
			dodgeText.get_node("text").text = "Successful dodge!"
			
		dodgeText.position = Vector2(0, 0)


func _on_attack_clicked(_viewport, _event, _shape_idx):
	if(isProcessed):
		return
		
	if(Input.is_action_just_pressed("click")):
		player.get_node("AnimationPlayer").play("player_attack")
