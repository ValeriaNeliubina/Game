extends Sprite

signal button_pressed

export var code: String
export var artifact: String
export var price: int

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			emit_signal("button_pressed", code, artifact)

func change_visible(charisma: int):
	if charisma >= price and Progress.has_artifact(artifact):
		self.modulate.a = 1
	else:
		self.modulate.a = 0.3
