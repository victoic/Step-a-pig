class_name Wall extends CollisionShape2D

const LEFT_SIDE: int = 0
const RIGHT_SIDE: int = 1
const UP_SIDE: int = 2
const DOWN_SIDE: int = 3

@export var side: int = 0


func _ready() -> void:
	if is_instance_of(shape, SegmentShape2D):
		if side == LEFT_SIDE:
			shape.a = Vector2(0, 0)
			shape.b = Vector2(0, get_viewport_rect().size.y)
		elif side == RIGHT_SIDE:
			shape.a = Vector2(get_viewport_rect().size.x, 0)
			shape.b = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
		elif side == UP_SIDE:
			shape.a = Vector2(0, 0)
			shape.b = Vector2(get_viewport_rect().size.x, 0)
		elif side == DOWN_SIDE:
			shape.a = Vector2(0, get_viewport_rect().size.y)
			shape.b = Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y)
