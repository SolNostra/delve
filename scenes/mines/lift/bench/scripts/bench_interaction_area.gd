extends InteractableArea

func _on_body_entered(body: Node3D) -> void:
	on_interactible_area_entered()

func _on_body_exited(body: Node3D) -> void:
	on_interactible_area_exited()
	
	
	
