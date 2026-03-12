class_name Breakout extends Node2D

@export var level_data: LevelData

@onready var player: Player = $Player
@onready var pig_container: PigContainer = $PigContainer
@onready var death_zone: Area2D = $DeathZone

static var is_game_over: bool = false

func _ready() -> void:
	pig_container.setup(level_data.load_map())
	death_zone.position.x = get_viewport_rect().size.x / 2
	death_zone.position.y = get_viewport_rect().size.y

func _on_death_zone_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Ball):
		player.lives -= 1
		body.reset()

func _on_player_game_over() -> void:
	is_game_over = true
