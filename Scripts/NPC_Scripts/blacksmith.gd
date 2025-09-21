extends Sprite3D

var has_interacted: bool
var count: float

func _ready():
	has_interacted = false
	count = 0

func start_dialog():
	if (DialogueManager.dialogue_started):
		GlobalData.talking_to_npc = true
		
	var resource = load("res://Dialogue/blacksmith_dialogue.dialogue")
	var section
	if (has_interacted): 
		section = "random"
	else:
		section = "start"
	#var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, section)
	
	# then
	DialogueManager.show_dialogue_balloon(resource, section)
