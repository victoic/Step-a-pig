class_name Player extends CharacterBody2D

signal game_over
signal changed_life(lives: int)
signal spawn_on_game(node: Node2D)

@onready var polygon: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var lives: int = 3:
	set(value):
		lives = value
		changed_life.emit(lives)
		if lives <= 0:
			game_over.emit()
@export var speed: float = 480

@onready var blank_power_up: PackedScene = load("res://scenes/power_ups/blank/blank_power_up.tscn")
@export var power_up: PowerUp

var half_bar_size: Vector2 = Vector2.ZERO
var bar_size: Vector2 = Vector2(100, 10):
	set(value):
		bar_size = value
		set_sizes()

func set_sizes() -> void:
	var total_size: Vector2 = bar_size + power_up.size_mod if power_up else bar_size
	polygon.polygon = PackedVector2Array([
		Vector2(0, 0) - (total_size / 2),
		Vector2(0, total_size.y) - (total_size / 2),
		Vector2(total_size.x, total_size.y) - (total_size / 2),
		Vector2(total_size.x, 0) - (total_size / 2)
	])
	collision.shape.size = total_size
	half_bar_size = total_size / 2

func deg_to_vec(deg: float) -> Vector2:
	var rotation_radians = deg_to_rad(deg)
	var direction = Vector2(sin(rotation_radians), cos(rotation_radians))
	return direction

func get_hit_angle(ball: Ball) -> Vector2:
	var n: Vector2 = Vector2.UP
	
	var pos_diff: float = ball.position.x - position.x
	var ratio_x: float = pos_diff / ((bar_size.x + power_up.size_mod.x) / 2)
	var rotation_deg: float = ratio_x * 75
	var d: Vector2 = deg_to_vec(rotation_deg)
	
	var r: Vector2 = d - 2 * (d.dot(n)) * n
	return r

func remove_power_up():
	set_power_up(blank_power_up.instantiate())

func set_power_up(new_power_up: PowerUp):
	remove_child(power_up)
	power_up = new_power_up
	add_child(power_up)
	set_sizes()

func get_moved_position(diff: float):
	return clampf(
		position.x + diff, 
		half_bar_size.x + Breakout.walls_padding, 
		get_viewport_rect().size.x - half_bar_size.x - Breakout.walls_padding
	)

func _ready() -> void:
	set_sizes()
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y - 80
	power_up = blank_power_up.instantiate()
	add_child(power_up)

func _physics_process(delta: float) -> void:
	if not Breakout.is_game_over and not Breakout.player_paused:
		if not power_up._on_action_just_pressed(self, delta):
			if Input.is_action_pressed("left"):
				position.x -= (speed + power_up.speed_mod.x) * delta
			elif Input.is_action_pressed("right"):
				position.x += (speed + power_up.speed_mod.x) * delta
		position.x = clampf(
			position.x, 
			half_bar_size.x + Breakout.walls_padding, 
			get_viewport_rect().size.x - half_bar_size.x - Breakout.walls_padding
		)
