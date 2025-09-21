extends Area3D

@onready var HUD = %HUD
var player_in_range = false
var player_node = null
var interact_label : Label


func _ready():
	#$Area3D.body_entered.connect(_on_body_entered)
	#$Area3D.body_exited.connect(_on_body_exited)
	
	interact_label = HUD.get_node("InteractionLabel")

func _on_body_entered(body):
	if body.name == "Player3D":  # Or check with body.is_in_group("player")
		body.current_interactable = self
		player_in_range = true
		player_node = body
		if interact_label:
			interact_label.visible = true

func _on_body_exited(body):
	if body.name == "Player3D":
		player_in_range = false
		player_node = null
		body.current_interactable = null
		print('interact_label:', interact_label)
		GlobalData.talking_to_npc = false
		if interact_label:
			interact_label.visible = false
			interact_label.text = ""

#func _process(delta):
	#if player_in_range and Input.is_action_just_pressed("ui_interact"):
		#start_dialog()

		
func start_dialog():
	if (DialogueManager.dialogue_started):
		GlobalData.talking_to_npc = true
		
	print("Skelly talking talking")
	
	var resource = load("res://Dialogue/skeleton_dialogue.dialogue")
	var dialogue_line 
	var section = "start"
	
	# then
	DialogueManager.show_dialogue_balloon(resource, section)

		
