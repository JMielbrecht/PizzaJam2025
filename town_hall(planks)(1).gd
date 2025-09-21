extends MeshInstance3D

@onready var target = get_node("TargetBox")

var is_complete: bool = false

func _physics_process(delta):
	
	if is_complete == false:
		
		if target.is_hit:
			is_complete = true
			visible = false
			#print("DONE")
		
	
	pass
