class_name Pig extends RigidBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var health: int = 1
@export var speed: Vector2 = Vector2(0, 5)

func take_hit(damage: int) -> void:
	health -= damage
	if health <= 0:
		animation_player.play("death")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()

func _physics_process(delta: float) -> void:
	move_and_collide(speed * delta)
