class_name Player extends CharacterBody2D

signal game_over

@onready var polygon: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var lives: int = 3:
	set(value):
		lives = value
		if lives <= 0:
			game_over.emit()
@export var speed: float = 480
var half_bar_size: Vector2 = Vector2.ZERO
var bar_size: Vector2 = Vector2(100, 10):
	set(value):
		bar_size = value
		set_sizes()

func set_sizes() -> void:
	polygon.polygon = PackedVector2Array([
		Vector2(0, 0) - (bar_size / 2),
		Vector2(0, bar_size.y) - (bar_size / 2),
		Vector2(bar_size.x, bar_size.y) - (bar_size / 2),
		Vector2(bar_size.x, 0) - (bar_size / 2)
	])
	collision.shape.size = bar_size
	half_bar_size = bar_size / 2

func deg_to_vec(deg: float) -> Vector2:
	var rotation_radians = deg_to_rad(deg)
	var direction = Vector2(sin(rotation_radians), cos(rotation_radians))
	return direction

func get_hit_angle(ball: Ball) -> Vector2:
	var n: Vector2 = Vector2.UP
	
	var pos_diff: float = ball.position.x - position.x
	var ratio_x: float = pos_diff / (bar_size.x / 2)
	var rotation_degrees: float = ratio_x * 75
	var d: Vector2 = deg_to_vec(rotation_degrees)
	
	var r: Vector2 = d - 2 * (d.dot(n)) * n
	return r

func _ready() -> void:
	set_sizes()
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y - 80

func _physics_process(delta: float) -> void:
	if not Breakout.is_game_over:
		if Input.is_action_pressed("left"):
			position.x -= speed * delta
		elif Input.is_action_pressed("right"):
			position.x += speed * delta
		position.x = clampf(position.x, half_bar_size.x, get_viewport_rect().size.x - half_bar_size.x)
