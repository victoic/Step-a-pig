class_name ExplosionBallPowerUp extends PowerUp

@onready var area: Area2D = $Area2D
@onready var area_collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var explosion_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var cur_actor: Object

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	if Input.is_action_just_pressed("click"):
		cur_actor = actor
		animation_player.play("explosion")
		for body in area.get_overlapping_bodies():
			if is_instance_of(body, Pig):
				body.take_hit(1)
	return animation_player.is_playing()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explosion":
		cur_actor.remove_power_up()
