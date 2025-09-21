extends Node3D

@export var player : CharacterBody3D
@onready var dust_pivot = $DustPivot
@onready var animated_sprite = %DustAnim

@onready var dog = $DogSprite
@onready var skele = $SkeletonSprite

@export var bone1 : Node3D
@export var bone2 : Node3D
@export var skull : Node3D

var is_completed : bool = false

var progress = 1
var dog_skel_progress = 0

func _physics_process(delta):
	
	animated_sprite.play("default")
	
	#dust_pivot.rotation.y = rotate_toward(dust_pivot.rotation.y, 
	#-atan2(player.global_position.z, player.global_position.x),
	#delta * 10)
	#dust_pivot.look_at(player.global_position)
	
	if bone1.is_complete:
		if bone2.is_complete:
			if skull.is_complete:
				is_completed = true
				
				#print("BONE COMPLETE")
				
				progress -=  0.3 * delta
				dog_skel_progress += 0.3 * delta
				
				animated_sprite.modulate = Color(1,1,1,progress)
				
				dog.modulate = Color(1,1,1,dog_skel_progress)
				skele.modulate = Color(1,1,1,dog_skel_progress)
	
	
	
