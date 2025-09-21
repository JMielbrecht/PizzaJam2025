extends Node3D

var is_complete: bool = false
var is_hit: bool = false

@onready var target = get_node("TargetBox")

func _ready():
	$GhostPiano.visible = false

func _physics_process(delta):
	
	is_hit = target.is_hit
	
	if is_complete == false:
		if is_hit:
			$PianoAlive.visible = false
			$GhostPiano.visible = true
			is_complete = true
			#print("PIANO")
	
