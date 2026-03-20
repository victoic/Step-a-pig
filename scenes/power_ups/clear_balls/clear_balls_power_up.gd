class_name ClearBallsPowerUp extends PowerUp

@onready var explosion_sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var cur_actor: Object

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	if Input.is_action_just_pressed("click"):
		var balls: Array[Node] = get_tree().get_nodes_in_group("ball")
		var len_balls: int = len(balls)
		var to_clear: Array[Ball] = []
		for i in range(1, len_balls):
			balls[i].queue_free()
		cur_actor.remove_power_up()
	return true
