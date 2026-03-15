class_name Wall extends CollisionShape2D

const LEFT_SIDE: int = 0
const RIGHT_SIDE: int = 1
const UP_SIDE: int = 2
const DOWN_SIDE: int = 3

@export var side: int = 0
@export var is_border: bool = true

func _ready() -> void:
	if is_instance_of(shape, SegmentShape2D) and is_border:
		if side == LEFT_SIDE:
			shape.a = Vector2(0 + Breakout.walls_padding, 0)
			shape.b = Vector2(0 + Breakout.walls_padding, get_viewport_rect().size.y)
		elif side == RIGHT_SIDE:
			shape.a = Vector2(get_viewport_rect().size.x - Breakout.walls_padding, 0)
			shape.b = Vector2(get_viewport_rect().size.x - Breakout.walls_padding, get_viewport_rect().size.y)
		elif side == UP_SIDE:
			shape.a = Vector2(0 + Breakout.walls_padding, 0)
			shape.b = Vector2(get_viewport_rect().size.x - Breakout.walls_padding, 0)
		elif side == DOWN_SIDE:
			shape.a = Vector2(0 + Breakout.walls_padding, get_viewport_rect().size.y)
			shape.b = Vector2(get_viewport_rect().size.x - Breakout.walls_padding, get_viewport_rect().size.y)
