extends Node
class_name DeathComponent

@export var health_component : HealthComponent

func _ready() -> void:
	health_component.resource_changed.connect(_on_health_changed)

func _on_health_changed(update: ResourceUpdate) -> void:
	if update.CurrentValue <= 0 and not health_component.godmode:
		die()
	
func die() -> void:
	get_tree().quit() # du bist tot :(
