class_name Breakout extends Node2D

@export var level_data: LevelData

@onready var player: Player = $Player
@onready var pig_container: PigContainer = $PigContainer

func _ready() -> void:
	pig_container.setup(level_data.load_map())


func _on_death_zone_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Ball):
		player.lives -= 1
		body.reset()
