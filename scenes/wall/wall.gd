class_name Wall extends CollisionShape2D

const LEFT_SIDE: int = 0
const RIGHT_SIDE: int = 1
const UP_SIDE: int = 2
const DOWN_SIDE: int = 3

@export var side: int = 0
@export var is_border: bool = true

func _ready() -> void:
	if is_instance_of(shape, RectangleShape2D) and is_border:
		if side == LEFT_SIDE:
			shape.size = Vector2(Breakout.walls_padding, get_viewport_rect().size.y)
			position = shape.size/2
		elif side == RIGHT_SIDE:
			shape.size = Vector2(Breakout.walls_padding, get_viewport_rect().size.y)
			position = Vector2(get_viewport_rect().size.x - Breakout.walls_padding / 2, get_viewport_rect().size.y / 2)
		elif side == UP_SIDE:
			shape.size = Vector2(get_viewport_rect().size.x, Breakout.walls_padding)
			position = Vector2(get_viewport_rect().size.x / 2, - Breakout.walls_padding / 2)
	if is_instance_of(shape, SegmentShape2D) and is_border:
		if side == DOWN_SIDE:
			shape.a = Vector2(0 + Breakout.walls_padding, get_viewport_rect().size.y)
			shape.b = Vector2(get_viewport_rect().size.x - Breakout.walls_padding, get_viewport_rect().size.y)
