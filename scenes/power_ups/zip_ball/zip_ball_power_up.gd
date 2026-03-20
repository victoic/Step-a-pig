class_name ZipBallPowerUp extends PowerUp

@onready var line: Line2D = $Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var zip_ray_scene: PackedScene = load("res://scenes/power_ups/zip_ball/zip_ray_2d.tscn")

func _on_action_just_pressed(actor: Object, delta: float) -> bool:
	if Input.is_action_just_pressed(action):
		if zip_ray_scene.can_instantiate():
			line.clear_points()
			line.add_point(to_local(actor.position))
			var ray_continue: bool = true
			while (ray_continue):
				var start: Vector2 = to_local(actor.position)
				var end: Vector2 = to_local(actor.position + (actor.speed + speed_mod) * actor.angle) * 2
				var zip_ray: ZipRay2D = zip_ray_scene.instantiate()
				actor.add_child(zip_ray)
				zip_ray.run(end)
				var collider: Node = zip_ray.get_collider()
				line.add_point(zip_ray.get_collision_point())
				if is_instance_of(collider, Wall):
					end = zip_ray.get_collision_point()
					actor.position = end
					ray_continue = false
				elif is_instance_of(collider, Pig):
					start = zip_ray.get_collision_point()
					collider.take_hit(damage)
			animation_player.play()
			return true
	return false
