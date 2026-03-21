class_name ZipBallPowerUp extends PowerUp

@onready var line: Line2D = $Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var zip_ray: ZipRay2D = $RayCast2D
@onready var global_target: Vector2 = to_global(Vector2.ZERO)

var cur_actor: Object
var is_waiting: bool = false

func _ready() -> void:
	line.visible = false

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	var found_collision: bool = false
	if Input.is_action_just_pressed(action) and not is_waiting:
		cur_actor = actor
		var global_start: Vector2 = actor.position
		var start: Vector2 = to_local(actor.position)
		var end: Vector2 = to_local(actor.position + actor.angle * 1000)
		zip_ray.clear_exceptions()
		while (true):
			zip_ray.position = start
			zip_ray.run(end)
			zip_ray.force_raycast_update()
			var collider: CollisionObject2D = zip_ray.get_collider()
			if collider != null:
				var shape_id: int = zip_ray.get_collider_shape()
				var owner_id: int = collider.shape_find_owner(shape_id)
				var shape: CollisionShape2D = collider.shape_owner_get_owner(owner_id)
				if is_instance_of(collider, Pig):
					start = to_local(zip_ray.get_collision_point())
					collider.take_hit(damage)
					zip_ray.add_exception(collider)
				elif is_instance_of(shape, Wall):
					actor.position = zip_ray.get_collision_point()
					line.position = Vector2.ZERO
					line.clear_points()
					line.add_point(Vector2.ZERO)
					var line_end: Vector2 = to_local(global_start)
					line.add_point(line_end)
					found_collision = true
					break
			else:
				break
	if found_collision:
		animation_player.play("zip_ball")
		zip_ray.position = Vector2.ZERO
		is_waiting = true
	if found_collision or is_waiting:
		return true
	return false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "zip_ball":
		cur_actor.remove_power_up()
