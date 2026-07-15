extends Area3D
class_name InteractableArea

@export var can_interact := true
@export var can_hold := false

signal interacted(properties: InteractionController.InteractedProperties)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	set_collision_layer_value(6, true)
	set_collision_layer_value(1, false)

func _on_body_entered(_body: Node3D) -> void:
	PlayerManager.player.interaction_controller.interactable_area_entered(self)

func _on_body_exited(_body: Node3D) -> void:
	PlayerManager.player.interaction_controller.interactable_area_exited(self)

func interact(properties: InteractionController.InteractedProperties) -> void:
	interacted.emit(properties)
