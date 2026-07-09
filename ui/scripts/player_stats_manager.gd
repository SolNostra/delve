extends Node
class_name PlayerStatsManager

var player : Player

var health_component : HealthComponent
var stamina_component : StaminaComponent

@export var health_label : RichTextLabel
@export var stamina_label : RichTextLabel

func _ready() -> void:
	set_player()
	if not player:
		return
	
	player.health_component.resource_changed.connect(update_health)
	player.stamina_component.resource_changed.connect(update_stamina)
	health_component.initialize_resource()
	stamina_component.initialize_resource()

func set_player() -> void:
	player = PlayerManager.player
	if not player:
		return
	
	health_component = player.health_component
	stamina_component = player.stamina_component

func update_health(update: ResourceUpdate) -> void:
	health_label.text = "HEALTH: %d/%d" % [update.CurrentValue, update.MaxValue]
	
func update_stamina(update: ResourceUpdate) -> void:
	stamina_label.text = "STAMINA: %d/%d" % [update.CurrentValue, update.MaxValue]
