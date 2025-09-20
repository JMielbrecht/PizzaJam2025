extends Node3D

@export var interact_label: Label  # Optional, for UI prompt
var player_in_range = false
var player_node = null

func _ready():
	$Area3D.body_entered.connect(_on_body_entered)
	$Area3D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	print("entered by", body)
	if body.name == "Player3D":  # Or check with body.is_in_group("player")
		print("interactable!!!")
		body.current_interactable = self
		player_in_range = true
		player_node = body
		if interact_label:
			interact_label.visible = true

func _on_body_exited(body):
	print("exited")
	if body.name == "Player":
		player_in_range = false
		player_node = null
		if interact_label:
			interact_label.visible = false
			body.current_interactable = null

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_interact"):
		start_dialog()

func start_dialog():
	var mistress = get_child(0)  # <-- Mistress.gd is on the parent Sprite3D
	print(mistress)
	if mistress and mistress.has_method("start_dialog"):
		print("start the dialogue?")
		mistress.start_dialog()
