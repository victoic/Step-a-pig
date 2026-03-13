class_name Breakout extends Node2D

@export var level_data: LevelData

@onready var player: Player = $Player
@onready var pig_container: PigContainer = $PigContainer
@onready var death_zone: Area2D = $DeathZone
@onready var crowd: Sprite2D = $Crowd
@onready var gui: GUI = $GUI

static var walls_padding: float = 40
static var is_game_over: bool = false

'''
TODO: 	- add bounce detection on sides (and fix upper wall);
		- add levels (different times in history)
		- add power-ups (teleport, explosion, etc)
		- add crowd below player paddle
		- detect game over if pigs get to crowd
'''

func _ready() -> void:
	pig_container.setup(level_data.load_map())
	death_zone.position = get_viewport_rect().size / 2
	crowd.position.x = get_viewport_rect().size.x / 2
	crowd.position.y = get_viewport_rect().size.y - (crowd.texture.get_size().y / crowd.vframes / 2)

func _on_player_game_over() -> void:
	is_game_over = true

func _on_death_zone_body_exited(body: Node2D) -> void:
	if is_instance_of(body, Ball):
		player.lives -= 1
		body.reset()

func _on_player_changed_life(lives: int) -> void:
	gui.change_lives(lives)
