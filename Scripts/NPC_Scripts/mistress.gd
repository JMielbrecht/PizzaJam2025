extends Sprite3D

var has_interacted: bool
var count: float


func _ready():
	has_interacted = false

func start_dialog():
	if (DialogueManager.dialogue_started):
		print("STAAAARRRRRT")
		GlobalData.talking_to_npc = true
		
	print("Lady talking")
	
	var resource = load("res://Dialogue/mistress_dialogue.dialogue")
	var finishedTask = GlobalData.mistress_task_complete
	var dialogue_line 
	var section = ""
	if (finishedTask):
		print("Talking after help")
		section = "after_help"
	elif (has_interacted):
		print("interlude")
		section = "in_between"
	else:
		print("Talking before help")
		section = "start"
		has_interacted = true
	
	# then
	DialogueManager.show_dialogue_balloon(resource, section)
