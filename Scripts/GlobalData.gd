extends Node

@export var farmer_task_complete : bool = false
@export var mistress_task_complete : bool = false
@export var schoolmarm_task_complete : bool = false
@export var mayor_task_complete : bool = false
@export var undertaker_task_complete : bool = false

func _ready():
	randomize()
