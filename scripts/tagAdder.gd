extends OptionButton

@export var tagNum = 1

@onready var judgeManager = get_tree().get_root().get_node("game/judgeManager")
var tags = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var tmpString = str("Tag #", tagNum)
	add_item(tmpString)
	tags = judgeManager.tags
	for tag in tags:
		add_item(tag)
