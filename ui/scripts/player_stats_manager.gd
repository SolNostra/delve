extends Node
class_name PlayerStatsManager

var player : Player

var health_component : HealthComponent

@export var health_label : RichTextLabel

func _ready() -> void:
	set_player()
	if not player:
		return
	
	player.health_component.resource_changed.connect(update_health)
	health_component.initialize_resource()

func set_player() -> void:
	player = PlayerManager.player
	if not player:
		return
	
	health_component = player.health_component

func update_health(update: ResourceUpdate) -> void:
	for status in health_component.health_to_status:
		if update.CurrentValue <= status:
			health_label.text = "STATUS: %s" % health_component.health_to_status.get(status)
			return
