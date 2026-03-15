class_name PigContainer extends Node2D

@onready var pig_scene: PackedScene = load("res://scenes/pig/pig.tscn")

@export var padding: float = 1

func setup(scenes: Array[Array], game: Breakout) -> void:
	var starting_y: float = 12
	for row: Array in scenes:
		var total_unusable: float = 2 * Breakout.walls_padding
		var total_used: float = 38 * len(row) + padding * (len(row) - 1)
		var remaining_width = get_viewport_rect().size.x - total_unusable
		var starting_x: float = (remaining_width - total_used) / 2 + Breakout.walls_padding
		for pig_type: PackedScene in row:
			var new_pig: Pig = pig_type.instantiate()
			add_child(new_pig)
			new_pig.position = Vector2(starting_x, starting_y)
			new_pig.game_over.connect(game._on_pig_game_over)
			new_pig.spawn_bullet.connect(game._on_pig_spawn_bullet)
			new_pig.spawn_boom.connect(game._on_spawn_boom)
			starting_x += 38 + padding
		starting_y += 24
