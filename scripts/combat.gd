extends Node2D

enum{PLAYER, ENEMY, END}

@onready var initMenu = get_node("initMenu")
@onready var attackMenu = get_node("attackMenu")
@onready var dodgeText = get_node("dodgeText")

@onready var inventionManager = get_tree().get_root().get_node("game/inventionManager")
@onready var sceneManager = get_tree().get_root().get_node("game/sceneManager")

@onready var playerNode = get_parent().get_node("player")
@onready var enemyNode = get_parent().get_node("enemy")

@export var wintext = "Fish 1: You are an honorable salesman. Go forth, and secure a good deal."
@export var losetext = "Fish 1: Terrible pitch. Go back to the drawing board."

@export var nextLevel = "room2"

class Agent:
	var health = 100
	var defense = 1
	var attack = 10
	var dodge = false
	
@onready var player = Agent.new()
@onready var enemy = Agent.new()

var turn = PLAYER

# Called when the node enters the scene tree for the first time.
func _ready():
	playerTurn()
	
	attackMenu.get_node("attack1/Button").text = inventionManager.feature1
	attackMenu.get_node("attack2/Button").text = inventionManager.feature2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func playerTurn():
	if(turn == END):
		return
	turn = PLAYER
	initMenu.show()
	attackMenu.hide()
	dodgeText.hide()
	
func enemyTurn():
	if(turn == END):
		return
	await get_tree().create_timer(1).timeout
	turn = ENEMY
	match(randi_range(0, 3)):
		0:
			_on_enemy_attack_raised()
		1:
			_on_enemy_defense_raised()
		2:
			_enemy_dodge()
		3:
			_on_enemy_attack()
			
	await get_tree().create_timer(1).timeout
		
	playerTurn()

func _on_attackmenu_clicked():
	initMenu.hide()
	attackMenu.show()

func _on_dodge_clicked():
	initMenu.hide()
		
	dodgeText.get_node("text").text = "Dodge failed!"
	player.dodge = false
		
	if(randi_range(0, 1) == 1):
		dodgeText.get_node("text").text = "Successful dodge!"
		player.dodge = true
			
	dodgeText.show()
	
	enemyTurn()

func _on_attack_clicked():
	playerNode.get_node("AnimationPlayer").play("player_attack")
	enemyNode.get_node("AnimationPlayer").play("judge_hurt")
	
	if(enemy.dodge == false):
		enemy.health -= (player.attack * enemy.defense)
	enemy.dodge = false
	
	attackMenu.hide()
	
	if(enemy.health <= 0):
		onWin()
	
	enemyTurn()
	
func _on_defense_raised():
	player.defense -= 0.05
	if(player.defense <= 0.1):
		player.defense = 0
		
	attackMenu.hide()
	dodgeText.show()
	
	dodgeText.get_node("text").text = "Defense raised!"
	
	enemyTurn()
	
func _on_attack_raised():
	player.attack += 2
	
	attackMenu.hide()
	dodgeText.show()
	
	dodgeText.get_node("text").text = "Attack raised!"
	
	
	enemyTurn()
	
func _on_enemy_attack_raised():
	enemy.attack += 2
	
	attackMenu.hide()
	dodgeText.show()
	
	dodgeText.get_node("text").text = "Enemy attack raised!"
	
func _on_enemy_defense_raised():
	enemy.defense -= 0.05
	if(enemy.defense <= 0.1):
		enemy.defense = 0
		
	attackMenu.hide()
	dodgeText.show()
	
	dodgeText.get_node("text").text = "Enemy defense raised!"
		
func _enemy_dodge():
	dodgeText.get_node("text").text = "Enemy dodge failed!"
	enemy.dodge = false
		
	if(randi_range(0, 1) == 1):
		dodgeText.get_node("text").text = "Successful enemy dodge!"
		enemy.dodge = true
			
	attackMenu.hide()
	initMenu.hide()
	dodgeText.show()

func _on_enemy_attack():
	playerNode.get_node("AnimationPlayer").play("player_damage")
	enemyNode.get_node("AnimationPlayer").play("judge_attack")
	
	if(player.dodge == false):
		player.health -= (enemy.attack * player.defense)
	player.dodge = false
	
	if(player.health <= 0):
		onLose()
		
func onLose():
	turn = END
	dodgeText.get_node("text").text = losetext
			
	attackMenu.hide()
	initMenu.hide()
	dodgeText.show()
	
	await get_tree().create_timer(5).timeout
	
	sceneManager.loadLevel("lose")
	
func onWin():
	turn = END
	dodgeText.get_node("text").text = wintext
			
	attackMenu.hide()
	initMenu.hide()
	dodgeText.show()
	
	await get_tree().create_timer(5).timeout
	
	sceneManager.loadLevel(nextLevel)















