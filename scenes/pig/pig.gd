class_name Pig extends RigidBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node) -> void:
	if is_instance_of(body, Ball):
		animation_player.play("death")
func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if is_instance_of(body, Ball):
		animation_player.play("death")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
