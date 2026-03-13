class_name TeleportPlayerPowerUp extends PowerUp

@onready var timer: Timer = $Timer
var single_press: bool = true
var last_direction: int = 0

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	var has_moved: bool = false
	var direction: int = 0
	if Input.is_action_just_pressed("left"):
		has_moved = true
		direction = -1
	if Input.is_action_just_pressed("right"):
		has_moved = true
		direction = 1
	if has_moved:
		print("{0} | {1}".format([direction, last_direction]))
		if single_press:
			actor.position.x += (direction * (actor.speed + actor.power_up.speed_mod.x)) * delta
			single_press = false
			timer.start()
			last_direction = direction
		elif not single_press and direction == last_direction:
			actor.position.x += direction * 400
			return true
	return false

func _on_timer_timeout() -> void:
	single_press = true
