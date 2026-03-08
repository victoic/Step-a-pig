class_name Ball extends StaticBody2D

@onready var polygon: Polygon2D = $Polygon2D

@export var speed: Vector2 = Vector2(125, 125)
@export var size: float = 10.0:
	set(value):
		size = value
		set_polygon()

func set_polygon() -> void:
	polygon.polygon = PackedVector2Array([
		Vector2(0, 0),
		Vector2(0, size),
		Vector2(size, size),
		Vector2(size, 0),
	])

func _ready() -> void:
	set_polygon()
