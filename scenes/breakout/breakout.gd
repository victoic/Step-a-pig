class_name Breakout extends Node2D

@export var level_data: LevelData

@onready var player: Player = $Player
@onready var ball: Ball = $Ball
@onready var pig_container: PigContainer = $PigContainer
@onready var one_shot_balls: Node2D = $OneShotBalls
@onready var death_zone: Area2D = $DeathZone
@onready var crowd: Sprite2D = $Crowd
@onready var background: Sprite2D = $Background
@onready var background_overlay: Sprite2D = $BackgroundOverlay
@onready var gui: GUI = $GUI
@onready var music_1: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var music_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var music_3: AudioStreamPlayer2D = $AudioStreamPlayer2D3

@onready var ball_scene: PackedScene = load("res://scenes/ball/ball.tscn")
@onready var boom_scene: PackedScene = load("res://scenes/boom/boom.tscn")

static var walls_padding: float = 40
static var is_game_over: bool = false
static var ball_paused: bool = false
static var pigs_paused: bool = false
static var player_paused: bool = false

'''
TODO: 	- add tutorial for power-ups
'''

func debug() -> void:
	ball_paused = true
	pigs_paused = true
	GameData.cur_level = "res://resources/levels/level_4.tres"

func _ready() -> void:
	#debug()
	is_game_over = false
	level_data = load(GameData.cur_level)
	set_music()
	pig_container.setup(level_data.load_map(), self)
	background.texture = load(level_data.bg)
	if level_data.bg_overlay != "none":
		background_overlay.texture = load(level_data.bg_overlay)
	death_zone.position = get_viewport_rect().size / 2
	crowd.position.x = get_viewport_rect().size.x / 2
	crowd.position.y = get_viewport_rect().size.y - (crowd.texture.get_size().y / crowd.vframes / 2)
	gui.change_life_icon(level_data.life_icon)
	gui.set_phrase(tr(level_data.phrase))

func pause() -> void:
	ball_paused = true
	pigs_paused = true
	player_paused = true

func unpause() -> void:
	ball_paused = false
	pigs_paused = false
	player_paused = false

func switch_phrase() -> void:
	var phrase: String = level_data.location_date if gui.phrase.text == tr(level_data.phrase) else tr(level_data.phrase)
	gui.set_phrase(tr(phrase))

func set_music() -> void:
	if level_data.play_music_1:
		music_1.play()
	if level_data.play_music_2:
		music_2.play()
	if level_data.play_music_3:
		music_3.play()

func to_menu() -> void:
	if level_data.is_ending:
		Stats.save_config(level_data.is_ending)
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

func _on_player_game_over() -> void:
	is_game_over = true

func _on_death_zone_body_exited(body: Node2D) -> void:
	if is_instance_of(body, Ball) and body.is_alive:
		player.lives -= 1
		if body.is_one_shot:
			body.queue_free()
		else:
			if not level_data.is_ending:
				_on_spawn_boom(Vector2(body.position.x, body.position.y - 40))
				body.reset()
	elif is_instance_of(body, PowerUpPickup):
		body.queue_free()

func _on_player_changed_life(lives: int) -> void:
	gui.change_lives(lives)

func _process(delta: float) -> void:
	if len(pig_container.get_children()) == 0 and not is_game_over:
		is_game_over = true
		Stats.save_config(level_data.is_ending)
		gui.show_victory_panel()

func _on_button_pressed() -> void:
	GameData.cur_level = level_data.next_level
	get_tree().reload_current_scene()

func _on_pig_game_over() -> void:
	is_game_over = true
	Stats.save_config(level_data.is_ending)
	gui.show_loss_panel()

func _on_pig_spawn_bullet(pos: Vector2) -> void:
	if ball_scene.can_instantiate():
		var new_ball: Ball = ball_scene.instantiate()
		new_ball.is_one_shot = true
		one_shot_balls.add_child(new_ball)
		new_ball.position = pos
		new_ball.polygon.material = null
		new_ball.modulate = Color(0.234, 0.234, 0.234, 1.0)

func _on_spawn_boom(pos: Vector2) -> void:
	var boom: Boom = boom_scene.instantiate()
	add_child.call_deferred(boom)
	boom.position = pos

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
