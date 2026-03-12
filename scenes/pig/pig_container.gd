class_name PigContainer extends Node2D

@onready var pig_scene: PackedScene = load("res://scenes/pig/pig.tscn")

@export var padding: float = 1

func setup(scenes: Array[Array]) -> void:
	var starting_y: float = 100
	for row: Array in scenes:
		var starting_x: float = (get_viewport_rect().size.x - 2 * Breakout.walls_padding - 38 * len(row) - padding * (len(row) - 1)) / 2
		for pig_scene: PackedScene in row:
			var new_pig: Pig = pig_scene.instantiate()
			add_child(new_pig)
			new_pig.position = Vector2(starting_x, starting_y)
			starting_x += 38 + padding
		starting_y += 24
