extends Marker3D


@onready var player = %Player3D

@onready var c1

var is_complete: bool = false

func _process(delta):
	
	if is_complete == false:
		
		$c1.play("default")
		$c2.play("default")
		$c3.play("default")
		$c4.play("default")
		$c5.play("default")
		
		if player.global_position.distance_to(global_position) < 25:
			if player.chamber > 0:
				if Input.is_action_just_pressed("shoot"):
					
					is_complete = true
					
					$c1.play("fly")
					$c2.play("fly")
					$c3.play("fly")
					$c4.play("fly")
					$c5.play("fly")
				
				
				
				
	pass
