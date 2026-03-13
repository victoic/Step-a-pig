class_name Pig extends RigidBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var health: int = 1
@export var speed: Vector2 = Vector2(0, 2)
@export var power_up_chance: float = 0.1
const CHARGE_SPEED: Vector2 = Vector2(0, 50)
const MOVE_TOWARDS: float = 648

func take_hit(damage: int) -> void:
	health -= damage
	var rand: float = randf()
	if rand <= power_up_chance:
		var pickup: PowerUpPickup = PowerUpPickup.spawn()
		get_tree().get_root().add_child(pickup)
		pickup.position = position
		pickup.setup()
	if health <= 0:
		animation_player.play("death")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()

func _physics_process(delta: float) -> void:
	var cur_speed: Vector2 = speed if not Breakout.is_game_over else CHARGE_SPEED
	if position.y < MOVE_TOWARDS:
		move_and_collide(cur_speed * delta)
