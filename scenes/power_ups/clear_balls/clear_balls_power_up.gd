class_name ClearBallsPowerUp extends PowerUp

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var cur_actor: Object

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	if Input.is_action_just_pressed("click"):
		cur_actor = actor
		var balls: Array[Node] = get_tree().get_nodes_in_group("ball")
		var len_balls: int = len(balls)
		var to_clear: Array[Ball] = []
		for i in range(1, len_balls):
			balls[i].die()
		cur_actor.remove_power_up()
		return true
	return false
