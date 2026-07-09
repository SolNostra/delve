extends Node
class_name DeathComponent

signal player_died(death_type: String)
@export var health_component : HealthComponent

func _ready() -> void:
	health_component.resource_changed.connect(_on_health_changed)

func _on_health_changed(update: ResourceUpdate) -> void:
	if update.CurrentValue <= 0 and not health_component.godmode:
		die("generic")
	
func die(death_type: String) -> void:
	player_died.emit(death_type)
