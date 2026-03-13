class_name PowerUp extends Node2D

@export var speed_mod: Vector2 = Vector2.ZERO
@export var size_mod: Vector2 = Vector2.ZERO
@export var action: String = "none"
@export var damage: int = 1
@export var is_player: bool = true

func _on_hit_pig(ball: Ball, collision: KinematicCollision2D, collider: Pig) -> void:
	collider.take_hit(damage)
	var normal: Vector2 = collision.get_normal()
	if normal.x != 0:
		ball.angle.x = -ball.angle.x
	else:
		ball.angle.y = -ball.angle.y

func _on_hit_wall() -> void:
	pass

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	if action == 'none':
		return false
	return Input.is_action_just_pressed(action)
