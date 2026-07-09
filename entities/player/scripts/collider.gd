extends CollisionShape3D

@onready var movement_controller = %MovementController

func _ready() -> void:
	movement_controller.noclip_toggled.connect(_on_noclip_toggled)

func _on_noclip_toggled(state: bool) -> void:
	disabled = state
