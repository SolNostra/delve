extends Area3D
class_name InteractableArea

signal interacted()

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	set_collision_layer_value(6, true)
	set_collision_layer_value(1, false)

func _on_body_entered(body: Node3D) -> void:
	PlayerManager.player.interaction_controller.interactable_area_entered(self)

func _on_body_exited(body: Node3D) -> void:
	PlayerManager.player.interaction_controller.interactable_area_exited(self)

func interact() -> void:
	interacted.emit()
