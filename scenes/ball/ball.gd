class_name Ball extends RigidBody2D

@onready var polygon: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var speed: Vector2 = Vector2(375, 375)
@export var angle: Vector2 = Vector2(0.33, -1)
@export var direction: Vector2 = Vector2(1, -1)
@export var size: Vector2 = Vector2(10.0, 10.0):
	set(value):
		size = value
		set_polygon()
@export var is_one_shot: bool = false

@onready var blank_power_up: PackedScene = load("res://scenes/power_ups/blank/blank_power_up.tscn")
@onready var zip_power_up: PackedScene = load("res://scenes/power_ups/zip_ball/zip_ball_power_up.tscn")
@export var power_up: PowerUp

func set_polygon() -> void:
	var total_size: Vector2 = size + power_up.size_mod if power_up else size
	polygon.polygon = PackedVector2Array([
		Vector2(0, 0) - total_size / 2,
		Vector2(0, total_size.y) - total_size / 2,
		Vector2(total_size.x, total_size.y) - total_size / 2,
		Vector2(total_size.x, 0) - total_size / 2,
	])
	collision.shape.size = total_size

func remove_power_up():
	set_power_up(zip_power_up.instantiate())

func set_power_up(new_power_up: PowerUp):
	remove_child(power_up)
	power_up = new_power_up
	add_child(power_up)
	set_polygon()

func reset() -> void:
	size = Vector2(10.0, 10.0)
	position.x = get_viewport_rect().size.x / 2
	position.y = 566.0
	angle.y = -1

func _ready() -> void:
	reset()
	power_up = zip_power_up.instantiate()
	add_child(power_up)

func _physics_process(delta: float) -> void:
	if not Breakout.is_game_over and not Breakout.ball_paused:
		if not power_up._on_action_just_pressed(self, delta):
			var movement: Vector2 = (speed + power_up.speed_mod) * angle * delta
			var collision: KinematicCollision2D = move_and_collide(movement)
			if collision:
				var collider: Object = collision.get_collider()
				var collider_shape: Object = collision.get_collider_shape()
				if is_instance_of(collider_shape, Wall):
					if is_instance_of(collider, Player):
						angle = collider.get_hit_angle(self)
					else:
						if collider_shape.side == Wall.UP_SIDE:
							angle.y = -angle.y
						elif collider_shape.side == Wall.LEFT_SIDE or collider_shape.side == Wall.RIGHT_SIDE:
							angle.x = -angle.x
				elif is_instance_of(collider, Pig):
					power_up._on_hit_pig(self, collision, collider)
				
