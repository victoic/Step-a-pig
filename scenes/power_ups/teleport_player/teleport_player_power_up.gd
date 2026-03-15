class_name TeleportPlayerPowerUp extends PowerUp

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var teleport_trace_scene: PackedScene = load("res://scenes/power_ups/teleport_player/teleport_trace.tscn")

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
		if single_press:
			actor.position.x += (direction * (actor.speed + actor.power_up.speed_mod.x)) * delta
			single_press = false
			timer.start()
			last_direction = direction
		elif not single_press and direction == last_direction:
			var old_pos: float = actor.position.x
			var new_pos: float = actor.get_moved_position(direction * 400)
			var width: float = new_pos - old_pos
			actor.position.x = new_pos
			for breakout in get_tree().get_nodes_in_group("breakout"):
				if teleport_trace_scene.can_instantiate():
					var trace: TeleportTrace = teleport_trace_scene.instantiate()
					breakout.add_child(trace)
					trace.setup(width, actor.bar_size.x, actor.position)
			return true
	return false

func _on_timer_timeout() -> void:
	single_press = true
