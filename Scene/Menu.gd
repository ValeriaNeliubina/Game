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


func _on_NewGame_mouse_entered():
	get_node("Buttons/VBoxContainer2/VBoxContainer/NewGame").rect_scale = Vector2(1.05, 1.05)
	get_node("Buttons/ScaleAnimationPlayer").play("new_large")


func _on_NewGame_mouse_exited():
	get_node("Buttons/VBoxContainer2/VBoxContainer/NewGame").rect_scale = Vector2(1, 1)
	get_node("Buttons/ScaleAnimationPlayer").play("new_small")

func _on_Continue_mouse_entered():
	get_node("Buttons/VBoxContainer2/VBoxContainer/Continue").rect_scale = Vector2(1.05, 1.05)
	get_node("Buttons/ScaleAnimationPlayer").play("continue_large")


func _on_Continue_mouse_exited():
	get_node("Buttons/VBoxContainer2/VBoxContainer/Continue").rect_scale = Vector2(1, 1)
	get_node("Buttons/ScaleAnimationPlayer").play("continue_small")

func _on_Autors_mouse_entered():
	get_node("Buttons/VBoxContainer2/VBoxContainer/Autors").rect_scale = Vector2(1.05, 1.05)
	get_node("Buttons/ScaleAnimationPlayer").play("autors_large")


func _on_Autors_mouse_exited():
	get_node("Buttons/VBoxContainer2/VBoxContainer/Autors").rect_scale = Vector2(1, 1)
	get_node("Buttons/ScaleAnimationPlayer").play("autors_small")

func _on_Exit_mouse_entered():
	get_node("Buttons/VBoxContainer2/Exit").rect_scale = Vector2(1.05, 1.05)
	get_node("Buttons/ScaleAnimationPlayer").play("Inlarge")


func _on_Exit_mouse_exited():
	get_node("Buttons/VBoxContainer2/Exit").rect_scale = Vector2(1, 1)
	get_node("Buttons/ScaleAnimationPlayer").play("Enlarge")
