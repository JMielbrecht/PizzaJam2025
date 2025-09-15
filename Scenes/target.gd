extends Area3D


func _on_body_entered(body: Node3D) -> void:
	print("HIT!!!")
	body.queue_free()
	pass # Replace with function body.
