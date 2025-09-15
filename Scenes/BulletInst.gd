extends CharacterBody3D

@export var speed = 100

func _process(delta):
	position += transform.basis * Vector3(0.0, 0.0, -speed) * delta
	
