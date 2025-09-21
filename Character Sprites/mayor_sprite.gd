extends Sprite3D

func start_dialog():
	print("Farmer talking")
	var resource = load("res://Dialogue/mayor_dialogue.dialogue")
	var finishedTask = GlobalData.mayor_task_complete
	var dialogue_line 
	if (finishedTask):
		print("Talking after help")
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "after_help")
	else:
		print("Talking before help")
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	
	# then
	DialogueManager.show_dialogue_balloon(resource)
