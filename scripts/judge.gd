extends Node2D

@onready var judgeManager = get_tree().get_root().get_node("game/judgeManager")

var tags = ["gadget", "kitchen", "health", "smarthome", "outdoor", "pets", "fashion", "education", "transport", "beauty", "robotics", "decor", "travel", "environmental"]

var likes = []
var dislikes = []
var fishName

# Called when the node enters the scene tree for the first time.
func _ready():
	initJudge()
	print(fishName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func initJudge():
	#get name from judge manager
	fishName = judgeManager.getName()
	
	for x in range(3):
		#Make likes
		var tmp = randi_range(0, tags.size() - 1)
		likes.append(tags[tmp])
		tags.pop_at(tmp)
		
		#Make dislikes
		tmp = randi_range(0, tags.size() - 1)
		dislikes.append(tags[tmp])
		tags.pop_at(tmp)
