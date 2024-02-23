extends Node2D

var tags = ["gadget", "kitchen", "health", "smarthome", "outdoor", "pets", "fashion", "transport", "robotics", "weapon"]
var names = ["Gillian", "Maria", "Finley", "Nemo", "Fisher", "Sal Mon", "Marlin", "Coraline", "Sandy", "Shelly"]

func getName():
	var tmpIndex = randi_range(0, names.size() - 1)
	var tmpName = names[tmpIndex]
	names.pop_at(tmpIndex)
	return tmpName
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
