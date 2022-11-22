extends Sprite

export var images := {
	default = null,
}

export var max_count := 90

export var count := 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	update_bar()

func set_count(count: int) -> void:
	self.count = count
	update_bar()

func update_bar() -> void:
	var map_count: float = count * (5 / float(max_count))
	
	if map_count <= 3:
		self.texture = images[0]
	elif map_count <= 4:
		self.texture = images[3]
	elif map_count <= 5:
		self.texture = images[4]
	else:
		self.texture = images[5]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
