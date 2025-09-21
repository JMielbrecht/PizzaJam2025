extends Sprite3D

func start_dialog():
	print("Farmer talking")
	var resource = load("res://Dialogue/salami_dialogue.dialogue")
	var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	
	# then
	DialogueManager.show_dialogue_balloon(resource)
