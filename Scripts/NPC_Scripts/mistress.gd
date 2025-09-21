extends Sprite3D

var has_interacted: bool
var count: float

func _ready():
	has_interacted = false
	count = 0

func start_dialog():
	print("Mistress talking")
	count = count + 1
	print('COUNT IS NOW: ', count)
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
	resource.get_next_dialogue_line(section)
