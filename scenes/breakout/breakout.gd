class_name Breakout extends Node2D

@export var level_data: LevelData

@onready var player: Player = $Player
@onready var pig_container: PigContainer = $PigContainer
@onready var death_zone: Area2D = $DeathZone
@onready var crowd: Sprite2D = $Crowd
@onready var background: Sprite2D = $Background
@onready var gui: GUI = $GUI

static var walls_padding: float = 40
static var is_game_over: bool = false

'''
TODO: 	- add levels (different times in history)
		- detect game over if pigs get to crowd
		- change teleport to strech player collision while teleporting so pass through makes a hit
		- add music and SFX
			- dog_toy_latex_pig_slow.wav by magedu -- https://freesound.org/s/380497/ -- License: Attribution 4.0
			- Dog toy, rubber pig, squeak, oink, grunt, fast, single grunt_96Khz_Mono_ZoomH4n_NT5.wav by MattRuthSound -- https://freesound.org/s/561576/ -- License: Attribution 4.0
			- dog_toy_latex_pig.wav by magedu -- https://freesound.org/s/380500/ -- License: Attribution 4.0
			- Pig004.wav by yottasounds -- https://freesound.org/s/174614/ -- License: Attribution 3.0
'''

func _ready() -> void:
	level_data = load(GameData.cur_level)
	pig_container.setup(level_data.load_map())
	background.texture = load(level_data.bg)
	death_zone.position = get_viewport_rect().size / 2
	crowd.position.x = get_viewport_rect().size.x / 2
	crowd.position.y = get_viewport_rect().size.y - (crowd.texture.get_size().y / crowd.vframes / 2)
	gui.change_life_icon(level_data.life_icon)
	gui.set_phrase(level_data.phrase)

func _on_player_game_over() -> void:
	is_game_over = true

func _on_death_zone_body_exited(body: Node2D) -> void:
	if is_instance_of(body, Ball):
		player.lives -= 1
		body.reset()
	elif is_instance_of(body, PowerUpPickup):
		body.queue_free()

func _on_player_changed_life(lives: int) -> void:
	gui.change_lives(lives)

func _process(delta: float) -> void:
	if len(pig_container.get_children()) == 0:
		gui.show_victory_panel()

func _on_button_pressed() -> void:
	GameData.cur_level = level_data.next_level
	get_tree().reload_current_scene()
