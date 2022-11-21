extends Node

var files = File.new()
var data: Dictionary = {
	"part" : 0,
	"score" : 0,
	"artifacts" : [],
	"save": ""
}

var current_save_point: String = ""
var current_module: String = ""

func _ready():
	to_load()
	pass

func to_save():
	print("")
	files.open("res://save/save_game.txt", File.WRITE)
	files.store_var(data)
	files.close()

func to_load():
	print("")
	files.open("res://save/save_game.txt", File.READ)
	data = files.get_var()
	files.close()
	print(data)
	return true

func next_part():
	print("")
	data["part"] = data["part"] + 1
	
func add_score(score):
	print("")
	data["score"] = data["score"] + score
	if data["score"] < 0:
		data["score"] = 0
		return 0
	return true
	
func add_artifact(artifact):
	print("")
	var index = data["artifacts"].find(artifact)
	if index == -1:
		data["artifacts"].append(artifact)
		return true
	else:
		return false
	
func drop_artifact(artifact):
	print("")
	var index = data["artifacts"].find(artifact)
	if index > -1:
		data["artifacts"].remove(index)
		return true
	else:
		return false

func has_artifact(artifact):
	return data["artifacts"].find(artifact) > -1

func save_point(point: String):
	data["save"] = point
