class_name Ball extends RigidBody2D

@onready var polygon: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var speed: Vector2 = Vector2(375, 375)
@export var angle: Vector2 = Vector2(0.33, -1)
@export var direction: Vector2 = Vector2(1, -1)
@export var damage: int = 1
@export var size: Vector2 = Vector2(10.0, 10.0):
	set(value):
		size = value
		set_polygon()

func set_polygon() -> void:
	polygon.polygon = PackedVector2Array([
		Vector2(0, 0) - size / 2,
		Vector2(0, size.y) - size / 2,
		Vector2(size.x, size.y) - size / 2,
		Vector2(size.x, 0) - size / 2,
	])
	collision.shape.size = size

func reset() -> void:
	size = Vector2(10.0, 10.0)
	position.x = get_viewport_rect().size.x / 2
	position.y = 566.0
	angle.y = -1

func _ready() -> void:
	reset()

func _physics_process(delta: float) -> void:
	var movement: Vector2 = speed * angle * delta
	var collision: KinematicCollision2D = move_and_collide(movement)
	if collision:
		var collider: Object = collision.get_collider()
		var collider_shape: Object = collision.get_collider_shape()
		if is_instance_of(collider_shape, Wall):
			if is_instance_of(collider, Player):
				angle = collider.get_hit_angle(self)
			else:
				if collider_shape.is_horizontal:
					angle.x = -angle.x
				elif collider_shape.is_vertical:
					angle.y = -angle.y
		elif is_instance_of(collider, Pig):
			# detect which side to change direction
			collider.take_hit(damage)
			angle.y = -angle.y
		
