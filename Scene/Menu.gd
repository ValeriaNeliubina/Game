extends Control

func _on_Exit_pressed():
	get_tree().quit()

func _on_NewGame_pressed():
	Progress.current_save_point = ""
	Progress.current_module = "day_one"
	get_tree().change_scene("res://Main.tscn")

func _on_Continue_pressed():
	Progress.current_save_point = Progress.data["save"]
	Progress.current_module = "day_one"
	get_tree().change_scene("res://Main.tscn")
