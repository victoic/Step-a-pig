class_name Player extends CharacterBody2D

@onready var polygon: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var speed: float = 240
var bar_size: Vector2 = Vector2(100, 10):
	set(value):
		bar_size = value
		set_sizes()

func set_sizes() -> void:
	polygon.polygon = PackedVector2Array([
		Vector2(0, 0),
		Vector2(0, bar_size.y),
		Vector2(bar_size.x, bar_size.y),
		Vector2(bar_size.x, 0)
	])
	collision.shape.size = bar_size

func _ready() -> void:
	set_sizes()
	position.x = get_viewport_rect().size.x / 2 - bar_size.x / 2

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("right"):
		position.x += speed * delta
	position.x = clampf(position.x, 0, get_viewport_rect().size.x - bar_size.x)
