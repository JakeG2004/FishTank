extends Node2D

var points = []
var inventionName = ""
var feature1
var feature2
var tag1
var tag2
var tag3

var problem

class Point:
	var position: Vector2
	var color: Color
	
	func _init(pos: Vector2, col: Color):
		position = pos
		color = col

func _ready():
	problem = generateProblem()
	
func setData(newName, dFeature1, dFeature2, dTag1, dTag2, dTag3):
	inventionName = newName
	feature1 = dFeature1
	feature2 = dFeature2
	tag1 = dTag1
	tag2 = dTag2
	tag3 = dTag3

func getDrawing(newPoints):
	points = []
	for point in newPoints:
		points.append(point)
		
func sendDrawing():
	return points

func generateProblem():
	var nouns = ["Dolphin", "Shark", "Whale", "Seal", "Seagull", "Pelican", "Seastar", "Swordfish", 
					"Marlin", "Octopus", "Manta ray", "Nudibranch", "Plankton", "Kelp", "Seaweed", 
					"Jellyfish", "Clam", "Oyster", "Crab", "Lobster", "Shrimp", "Squid", "Anglerfish", 
					"Lionfish", "Clownfish", "Pufferfish", "Starfish", "Urchin", "Anemone", "Sponge", 
					"Sea cucumber", "Cuttlefish", "Skate", "Ray", "Stingray", "Hammerhead", "Bull shark", 
					"Bluefin tuna", "Yellowfin tuna", "Atlantic salmon", "Sockeye salmon", "Chinook salmon", 
					"Rainbow trout", "Brown trout", "Brook trout", "King crab", "Snow crab", "Blue crab", 
					"Lobster tail", "Spiny lobster", "Rock lobster"]
	
	var noun = nouns[randi_range(0, len(nouns) - 1)]

	var problems = ["My {} keeps running away!", "My brother doesn't believe that {} exists!", "I can't get rid of {}", "I'm scared of finding {} in my basement!", "My {} doesn't work!",
						"I accidentally turned my {} into a time machine and now I can't get back to the present!", "My cat is convinced that my {} is trying to steal her treats!",
						"Every time I try to cook {}, the fire alarm goes off!", "I woke up this morning and found {} in my bed!", "I think my house is haunted by {}",
						"My {} is so loud that it's scaring my neighbors!", "I accidentally signed up for a {} class and I have no idea where to start!",
						"I accidentally ordered {} instead of a pizza, now I don't know what to do with it!", "I accidentally shrunk my {} in the wash!",
						"I keep hearing strange noises coming from my {}, and I'm too scared to investigate it!", "I have a lot of things to try, but {} is on my lap!"]
	
	var tmpProblem = problems[randi_range(0, len(problems) - 1)]
	tmpProblem = (tmpProblem.format([noun], "{}"))
	
	return(tmpProblem)
