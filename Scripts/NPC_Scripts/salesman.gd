extends Sprite3D

var has_interacted: bool
var count: float

func _ready():
	has_interacted = false
	count = 0

func start_dialog():
	var resource = load("res://Dialogue/salesman_dialogue.dialogue")
	var section
	if (has_interacted): 
		section = "random"
	else:
		section = "start"
	#var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, section)
	
	# then
	DialogueManager.show_dialogue_balloon(resource, section)
