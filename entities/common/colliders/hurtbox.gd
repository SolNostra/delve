extends Area3D
class_name Hurtbox

@onready var azure_drill: Node3D = self.owner
@export var death_type := "drill"

func _on_body_entered(body: Node3D) -> void:
	if body is Player and azure_drill.drilling:
		body.death_component.die("drill")
		
