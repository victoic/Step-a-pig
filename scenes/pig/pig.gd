class_name Pig extends RigidBody2D

signal game_over
signal spawn_bullet(pos: Vector2)
signal spawn_boom(pos: Vector2)
signal pig_died

const CHARGE_SPEED: Vector2 = Vector2(0, 50)
const MOVE_TOWARDS: float = 648

static var game_over_emitted: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var health: int = 1
var is_dead: bool = false
@export var speed: Vector2 = Vector2(0, 2)
@export var power_up_chance: float = 0.1
@export var bullet_chance: float = 0.0
@export var boom_chance: float = 0.0001

func take_hit(damage: int) -> void:
	health -= damage
	if sprite.frame_coords.y + 1 < sprite.vframes:
		sprite.frame_coords.y += 1
	if health <= 0 and not is_dead:
		is_dead = true
		Stats.num_pigs += 1
		var rand: float = randf()
		if rand <= power_up_chance:
			var pickup: PowerUpPickup = PowerUpPickup.spawn()
			get_tree().get_root().add_child(pickup)
			pickup.position = position
			pickup.setup()
		animation_player.play("pig/death")
		rand = randf()
		if rand < bullet_chance:
			spawn_bullet.emit(position)
	else:
		audio_player.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pig/death":
		queue_free()

func _physics_process(delta: float) -> void:
	if not Breakout.pigs_paused:
		var cur_speed: Vector2 = speed if not Breakout.is_game_over else CHARGE_SPEED
		if position.y < MOVE_TOWARDS:
			move_and_collide(cur_speed * delta)
		elif not game_over_emitted:
			game_over_emitted = true
			game_over.emit()
		else:
			var rand: float = randf()
			if rand < boom_chance:
				spawn_boom.emit(Vector2(position.x, position.y + 40))
