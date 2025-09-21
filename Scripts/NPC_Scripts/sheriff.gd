extends Sprite3D

func start_dialog():
	print("Farmer talking")
	var resource = load("res://Dialogue/sheriff_dialogue.dialogue")
	var finishedTask = GlobalData.farmer_task_complete && GlobalData.mayor_task_complete && GlobalData.mistress_task_complete && GlobalData.undertaker_task_complete
	var dialogue_line 
	if (finishedTask):
		print("Talking after help")
		# unlike other  NPCs, this dialogue is gonna set up the showdown with Johnny Salami
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "after_help")
	else:
		print("Talking before help")
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	
	# then
	DialogueManager.show_dialogue_balloon(resource)
