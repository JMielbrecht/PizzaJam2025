extends Marker3D


@onready var player = %Player3D



func _process(delta):
	if player.global_position.distance_to(global_position) < 25:
		if player.chamber > 0:
			if Input.is_action_just_pressed("shoot"):
				queue_free()
	pass
