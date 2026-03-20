class_name PowerUpPickup extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D

@export var speed: Vector2 = Vector2(0, 50)
@export var power_up_path: String = ""
@export var sprite_path: String = ""

func setup() -> void:
	if sprite_path != "":
		sprite.texture = load(sprite_path)

static var self_scene: PackedScene = load("res://scenes/power_up_pickup/power_up_pickup.tscn")
static var power_up_list: Array[Dictionary] = [
	 {
		"scene": "res://scenes/power_ups/zip_ball/zip_ball_power_up.tscn",
		"sprite": "res://assets/icons/icon_zip_ball.png"
	}
]
static func spawn() -> PowerUpPickup:
	var pickup: PowerUpPickup = self_scene.instantiate()
	var power_up: Dictionary = power_up_list.pick_random()
	pickup.power_up_path = power_up["scene"]
	pickup.sprite_path = power_up["sprite"]
	return pickup

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(speed * delta)
	if collision:
		if is_instance_of(collision.get_collider(), Player):
			var power_up_scene: PackedScene = load(power_up_path)
			var power_up: PowerUp = power_up_scene.instantiate()
			var group: StringName = "ball"
			if power_up.is_player:
				group = "player"
			for node: Object in get_tree().get_nodes_in_group(group):
				node.set_power_up(power_up)
			queue_free()
