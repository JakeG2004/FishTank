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
@onready var room1 = preload("res://scenes/levels/room1.tscn")
@onready var room2 = preload("res://scenes/levels/room2.tscn")
@onready var room3 = preload("res://scenes/levels/room3.tscn")
@onready var battle = preload("res://scenes/levels/battle.tscn")
@onready var battle2 = preload("res://scenes/levels/battle2.tscn")
@onready var battle3 = preload("res://scenes/levels/battle3.tscn")
@onready var test = preload("res://scenes/levels/nameInvent.tscn")
@onready var win = preload("res://scenes/levels/win.tscn")
@onready var lose = preload("res://scenes/levels/lose.tscn")
@onready var menu = preload("res://scenes/levels/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadLevel("menu")
	
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
		"menu":
			call_deferred("add_child", menu.instantiate())
		"test":
			call_deferred("add_child", test.instantiate())
		"room1":
			call_deferred("add_child", room1.instantiate())
		"room2":
			call_deferred("add_child", room2.instantiate())
		"room3":
			call_deferred("add_child", room3.instantiate())
		"battle":
			call_deferred("add_child", battle.instantiate())
		"battle2":
			call_deferred("add_child", battle2.instantiate())
		"battle3":
			call_deferred("add_child", battle3.instantiate())
		"win":
			call_deferred("add_child", win.instantiate())
		"lose":
			call_deferred("add_child", lose.instantiate())
