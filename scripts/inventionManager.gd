extends Node2D

var points = []

class Point:
	var position: Vector2
	var color: Color
	
	func _init(pos: Vector2, col: Color):
		position = pos
		color = col

func getDrawing(newPoints):
	points = []
	for point in newPoints:
		points.append(point)
	print("Received points")

func generateProblem():
	var nouns = ["ocean", "sea", "wave", "beach", "shore", "coast", "coral", "reef", "tide", "current", 
						"whale", "dolphin", "shark", "fish", "salmon", "trout", "tuna", "clam", "oyster", "crab", 
						"lobster", "shrimp", "squid", "jellyfish", "seagull", "pelican", "seal", "seastar", 
						"anglerfish", "swordfish", "marlin", "octopus", "manta ray", "nudibranch", "plankton", 
						"kelp", "seaweed", "shell", "fin", "scale", "tentacle", "gill", "scales", "fathom", "harbor", 
						"cove", "lagoon", "estuary", "atoll", "tidal pool", "mariculture", "fishing", "net", "boat"]
	
	var noun = nouns[randi_range(0, len(nouns) - 1)]

	var problems = ["My {} keeps running away!"]
	
	var problem = problems[0]
	print(problem.format([noun], "{}"))

func _ready():
	generateProblem()
