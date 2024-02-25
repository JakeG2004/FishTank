extends CharacterBody2D

@onready var sceneManager = get_tree().get_root().get_node("game/sceneManager")


@onready var ap = get_node("AnimationPlayer")
@onready var sprite = get_node("Sprite2D")

var direction = 0

const SPEED = 100

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var xDirection = Input.get_axis("ui_left", "ui_right")
	if xDirection:
		velocity.x = xDirection * SPEED
		direction = xDirection
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var yDirection = Input.get_axis("ui_up", "ui_down")
	if(yDirection):
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	sprite.flip_h = (direction > 0)

	updateAnims()

	move_and_slide()

func updateAnims():
	if(velocity.x > 0):
		ap.play("run")
	elif(velocity.x < 0):
		ap.play("run")
	elif(velocity.y < 0):
		ap.play("up")
	elif(velocity.y > 0):
		ap.play("down")
	else:
		ap.stop()
	

func _on_area_2d_area_entered(area):
	if(area.is_in_group("judge1")):
		sceneManager.loadLevel("battle")
	if(area.is_in_group("judge2")):
		sceneManager.loadLevel("battle2")
	if(area.is_in_group("judge3")):
		sceneManager.loadLevel("battle3")
