class_name DeathWall extends Wall

func _ready() -> void:
	shape.size = get_viewport_rect().size
