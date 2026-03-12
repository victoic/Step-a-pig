class_name DeathWall extends Wall

func _ready() -> void:
	shape.size = Vector2(get_viewport_rect().size.x, 20)
