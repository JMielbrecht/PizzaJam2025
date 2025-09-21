extends Sprite3D

var has_interacted: bool
var count: float

func _ready():
	has_interacted = false
	
func start_dialog():
	if (DialogueManager.dialogue_started):
		GlobalData.talking_to_npc = true
		
	var resource = load("res://Dialogue/mayor_dialogue.dialogue")
	var completed = GlobalData.undertaker_task_complete
	var section
	if (completed): 
		section = "after_help"
	elif (has_interacted):
		section = "in_between"
	else:
		section = "start"
	
	# then
	DialogueManager.show_dialogue_balloon(resource, section)
