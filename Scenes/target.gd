extends Area3D

@export var hit : bool = false

func _on_body_entered(body: Node3D) -> void:
	hit = true
	body.queue_free()
	pass # Replace with function body.
