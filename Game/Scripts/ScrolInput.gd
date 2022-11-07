extends Sprite

export var images := {
	default = null,
}

export var count := 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_bar(0)


func update_bar(_count: int) -> void:
	count = _count
	if count < 3:
		self.texture = images[0]
	elif count < 4:
		self.texture = images[3]
	elif count < 5:
		self.texture = images[4]
	else:
		self.texture = images[5]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
