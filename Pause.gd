extends CanvasLayer

onready var sound_player = get_node("AudioStreamPlayer")
onready var continue_button = get_node("CenterContainer/VBoxContainer/continue")
onready var exit_button = get_node("CenterContainer/VBoxContainer/exit")
onready var anim_player = get_node("AnimationPlayer")

func _ready() -> void: 
	get_tree().paused = true

func _on_continue_pressed():
	get_tree().paused = false
	queue_free()

func _on_continue_entered():
	play_sound()
	continue_button.rect_scale = Vector2(1.05, 1.05)
	anim_player.play("continue_enter")

func _on_continue_exited():
	continue_button.rect_scale = Vector2(1, 1)
	anim_player.play("continue_exited")

func _on_exit_entered():
	play_sound()
	exit_button.rect_scale = Vector2(1.05, 1.05)
	anim_player.play("exit_enter")

func _on_exit_exited():
	exit_button.rect_scale = Vector2(1, 1)
	anim_player.play("exit_exited")

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scene/Menu.tscn")

func play_sound():
	sound_player.play()
