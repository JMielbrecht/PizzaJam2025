extends Node3D

@onready var is_hit = %BookTarget.is_hit


var is_disappeared: bool = false

func _process(delta):
	
	is_hit = %BookTarget.is_hit
	
	#print(is_hit)
	
	if is_disappeared == false:
		if is_hit:
			queue_free()
		
		#print(abs(sprite.global_position - origin.global_position).length())
		
