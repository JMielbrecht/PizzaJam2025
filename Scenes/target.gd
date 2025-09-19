extends Area3D

@export var is_hit : bool = false

func _on_body_entered(body: Node3D) -> void:
	is_hit = true
	print("HIT")
	body.queue_free()
	pass # Replace with function body.
