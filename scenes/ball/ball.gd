class_name Ball extends RigidBody2D

@onready var polygon: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var speed: Vector2 = Vector2(125, 375)
@export var direction: Vector2 = Vector2(1, -1)
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

func _ready() -> void:
	set_polygon()
	position.x = get_viewport_rect().size.x / 2

func _physics_process(delta: float) -> void:
	var movement: Vector2 = speed * direction * delta
	var collision: KinematicCollision2D = move_and_collide(movement)
	if collision:
		var collider_shape: Object = collision.get_collider_shape()
		if is_instance_of(collider_shape, Wall):
			if collider_shape.is_horizontal:
				direction.x = -direction.x
			elif collider_shape.is_vertical:
				direction.y = -direction.y
