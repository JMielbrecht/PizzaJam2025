extends Sprite3D

func start_dialog():
	print("Mistress talking")
	var resource = load("res://Dialogue/mistress_dialogue.dialogue")
	var finishedTask = $GlobalData.mistress_task_complete
	var dialogue_line 
	if (finishedTask):
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "after_help")
	else:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	
	# then
	
