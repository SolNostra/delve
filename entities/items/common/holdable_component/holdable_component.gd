extends Node3D
class_name HoldableComponent

@export var holding_offset := Vector3.ZERO
@export var holding_rotation_offset := Vector3.ZERO

@onready var interactable_area: InteractableArea = $InteractableArea
@onready var collider: CollisionShape3D = %CollisionShape3D
@onready var parent = self.get_parent()

var held := false
var held_in := InteractionController.InteractedProperties.Neither

func _ready() -> void:
	interactable_area.interacted.connect(_on_interactable_area_interacted)

func _on_interactable_area_interacted(properties: InteractionController.InteractedProperties) -> void:
	if held:
		if properties == InteractionController.InteractedProperties.RightHand:
			PlayerManager.player.hands_component.drop_right_hand()
		elif properties == InteractionController.InteractedProperties.LeftHand:
			PlayerManager.player.hands_component.drop_left_hand()
	else:
		if properties == InteractionController.InteractedProperties.RightHand:
			PlayerManager.player.hands_component.place_in_right_hand(parent)
		elif properties == InteractionController.InteractedProperties.LeftHand:
			PlayerManager.player.hands_component.place_in_left_hand(parent)

func pick_up() -> void:
	collider.disabled = true
	held = true

func put_down() -> void:
	collider.disabled = false
	held = false

func _process(_delta: float) -> void:
	if held:
		if held_in == InteractionController.InteractedProperties.LeftHand:
			parent.global_position = PlayerManager.player.armature.left_hand_marker.global_position + holding_offset
			parent.rotation = PlayerManager.player.model.rotation + holding_rotation_offset
		elif held_in == InteractionController.InteractedProperties.RightHand:
			parent.global_position = PlayerManager.player.armature.right_hand_marker.global_position + holding_offset
			parent.rotation = PlayerManager.player.model.rotation + holding_rotation_offset
