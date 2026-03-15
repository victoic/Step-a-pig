class_name TeleportTrace extends StaticBody2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func setup(width: float, player_width: float, pos: Vector2) -> void:
	position = pos
	# Sets widths
	var direction: int = sign(width)
	var total_width: float = abs(width) - player_width
	collision.shape.b.x = total_width
	color_rect.size.x = total_width
	
	# Sets positions and rotations
	collision.position.x = -total_width if direction >= 0 else player_width
	color_rect.position.x = 0 if direction >= 0 else player_width
	collision.position.x -= player_width / 2
	color_rect.position.x -= player_width / 2
	if direction >= 0:
		color_rect.rotation_degrees = 180.0
		color_rect.position.y = 5
	else:
		color_rect.rotation_degrees = 0.0
		color_rect.position.y = -5
	animation_player.play("teleport")
