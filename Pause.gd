extends CanvasLayer

func _ready() -> void: 
	get_tree().paused = true

func _on_continue_pressed():
	get_tree().paused = false
	queue_free()


func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scene/Menu.tscn")
