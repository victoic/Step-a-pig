class_name Pig extends RigidBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var health: int = 1
@export var speed: Vector2 = Vector2(0, 5)
const CHARGE_SPEED: Vector2 = Vector2(0, 50)
const MOVE_TOWARDS: float = 648

func take_hit(damage: int) -> void:
	health -= damage
	if health <= 0:
		animation_player.play("death")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()

func _physics_process(delta: float) -> void:
	var cur_speed: Vector2 = speed if not Breakout.is_game_over else CHARGE_SPEED
	if position.y < MOVE_TOWARDS:
		move_and_collide(cur_speed * delta)
