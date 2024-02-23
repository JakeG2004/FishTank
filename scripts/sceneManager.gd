extends Node2D

var currentScene

#@onready var menu = preload("res://scenes/menu.tscn")
#@onready var music = preload("res://scenes/music.tscn")
#@onready var credits = preload("res://scenes/credits.tscn")
#@onready var levels = preload("res://scenes/levels.tscn")
#@onready var tutorial = preload("res://scenes/tutorial.tscn")
#@onready var level1 = preload("res://scenes/level1.tscn")
#@onready var level2 = preload("res://scenes/level2.tscn")
#@onready var level3 = preload("res://scenes/level3.tscn")
#@onready var level4 = preload("res://scenes/level4.tscn")
#@onready var level5 = preload("res://scenes/level5.tscn")

@onready var drawLev = preload("res://scenes/levels/draw.tscn")
@onready var test = preload("res://scenes/levels/nameInvent.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadLevel("draw")
	
func reload():
	loadLevel(currentScene)
	
	
func loadLevel(levelName):
	currentScene = levelName

	# If no level exists, don't try to delete the current level
	if get_child_count() > 0:
		for child in get_children():
			child.queue_free()
		
	await get_tree().create_timer(.1).timeout

	# Create level, set its name (for future reference), then add it to the sceneManager node
	# Use call deferred to do it in next idle frame. It does something with avoiding conflict in the main thread
	match levelName:
		"quit":
			get_tree().quit()
			return
		"draw":
			call_deferred("add_child", drawLev.instantiate())
		"test":
			call_deferred("add_child", test.instantiate())
