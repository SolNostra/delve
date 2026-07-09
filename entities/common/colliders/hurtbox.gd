extends Area3D
class_name Hurtbox

@export var death_type := "drill"

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.death_component.die("drill")
		
