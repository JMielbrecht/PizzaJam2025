extends Sprite3D

func start_dialog():
	if (DialogueManager.dialogue_started):
		GlobalData.talking_to_npc = true
		
	print("Skelly talking talking")
	
	var resource = load("res://Dialogue/skeleton_dialogue.dialogue")
	var dialogue_line 
	var section = "start"
	
	# then
	DialogueManager.show_dialogue_balloon(resource, section)
