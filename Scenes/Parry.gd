extends Node3D

@onready var animation_player = %AnimationPlayer

@onready var is_hit = %TargetBox.is_hit
@onready var sprite = %Sprite3D
@onready var origin = %Origin
@onready var player = %Player3D

var speed: float = 25
var is_complete: bool = false

func _process(delta):
	
	is_hit = %TargetBox.is_hit
	
	if is_hit:
		
		animation_player.pause()
		
		if is_complete == false:
			if is_hit:
				var dir = sprite.global_position.direction_to(origin.global_position)
				sprite.global_position += dir * delta * speed
			
			#print(abs(sprite.global_position - origin.global_position).length())
			
			if abs(sprite.global_position - origin.global_position).length() < 1:
				sprite.visible = false
				is_complete = true
	else:
		if animation_player.is_playing() == false:
			global_rotation_degrees.y = randf_range(-30, 30)
		#print(global_rotation_degrees.y)
		animation_player.play("throw")
		
