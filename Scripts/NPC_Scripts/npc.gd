extends Node3D

@export var interact_label_path: NodePath  # Optional, for UI prompt
var player_in_range = false
var player_node = null

func _ready():
	$Area3D.body_entered.connect(_on_body_entered)
	$Area3D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	print("entered")
	if body.name == "Player":  # Or check with body.is_in_group("player")
		player_in_range = true
		player_node = body
		var label = get_node_or_null(interact_label_path)
		if label:
			label.visible = true

func _on_body_exited(body):
	print("exited")
	if body.name == "Player":
		player_in_range = false
		player_node = null
		var label = get_node_or_null(interact_label_path)
		if label:
			label.visible = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_interact"):
		interact()

func interact():
	print("Interacting with NPC: ", name)
	# Replace this with whatever interaction you want — dialogue, quest, etc.
