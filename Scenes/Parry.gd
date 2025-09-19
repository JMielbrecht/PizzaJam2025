extends Node3D

@onready var is_hit = %TargetBox.is_hit
@onready var sprite = %Sprite3D
@onready var origin = %Origin

var speed: float = 10
var is_disappeared: bool = false

func _process(delta):
	
	is_hit = %TargetBox.is_hit
	
	#print(is_hit)
	
	if is_disappeared == false:
		if is_hit:
			var dir = sprite.global_position.direction_to(origin.global_position)
			sprite.global_position += dir * delta * speed
		
		#print(abs(sprite.global_position - origin.global_position).length())
		
		if abs(sprite.global_position - origin.global_position).length() < 0.1:
			sprite.modulate = Color(1,1,1,0)
			is_disappeared = true
