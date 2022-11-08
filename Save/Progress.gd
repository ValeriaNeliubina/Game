extends Node

var files = File.new()
var data: Dictionary = {
	"part" : 0,
	"score" : 0,
	"artifacts" : []
}
func _ready():
	pass

func to_save():
	files.open("user://save_game.txt", File.WRITE)
	files.store_var(data)
	files.close()

func to_load():
	files.open("user://save_game.txt", File.READ)
	data = files.get_var()
	files.close()
	print(data)
	return true

func next_part():
	data["part"] = data["part"] + 1
	
func add_score(score):
	data["score"] = data["score"] + score
	if data["score"] < 0:
		data["score"] = 0
		return 0
	return true
	
func add_artifact(artifact):
	var index = data["artifacts"].find(artifact)
	if index == -1:
		data["artifacts"].append(artifact)
		return true
	else:
		return false
	
func drop_artifact(artifact):
	var index = data["artifacts"].find(artifact)
	if index > -1:
		data["artifacts"].remove(index)
		return true
	else:
		return false
