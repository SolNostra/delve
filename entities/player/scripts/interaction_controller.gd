extends Node
class_name InteractionController

@onready var player_state_component: PlayerStateComponent = %PlayerStateComponent

enum InteractedProperties {
	LeftHand,
	RightHand,
	Neither,
	Both,
}
	
# Region Entering & Exiting
var interactables_nearby : Dictionary[InteractableArea, Label3D] = {}

func interactable_area_entered(area: InteractableArea) -> void:
	var new_hint = assign_hint_text(area)
	interactables_nearby[area] = new_hint

func interactable_area_exited(area: InteractableArea) -> void:
	interactables_nearby.erase(area)
	deassign_hint_text(area)

## Interacting
func _input(event: InputEvent) -> void:
	if PlayerManager.player.player_state_component.current_state == PlayerStateComponent.PlayerState.BUSY:
		return
	
	if interactables_nearby.is_empty():
		return
	
	if event.is_action_pressed("interact"):
		var interactable = interactables_nearby.keys().front()
		interactable.interact(InteractedProperties.Neither)
	elif event.is_action_pressed("left_hand"):
		var interactable = interactables_nearby.keys().front()
		interactable.interact(InteractedProperties.LeftHand)
	elif event.is_action_pressed("right_hand"):
		var interactable = interactables_nearby.keys().front()
		interactable.interact(InteractedProperties.RightHand)
	
	

## Hint Text - This could be it's own file honestly.
const HINT_NODE_NAME := "HINT_TEXT"
const HINT_OFFSET := Vector3(0, 2, 0)

func _process(_delta: float) -> void:
	for area in interactables_nearby:
		var hint = interactables_nearby[area]
		if player_state_component.is_player_state(PlayerStateComponent.PlayerState.BUSY):
			hint.hide()
			return
		
		hint.show()
		hint.global_position = ((area.global_position + PlayerManager.player.global_position) / 2) + HINT_OFFSET
func create_hint_text(interactable: InteractableArea) -> Label3D:
	var new_label = Label3D.new()
	new_label.name = "HINT_TEXT"
	new_label.text = get_interaction_key(interactable)
	new_label.billboard = true
	new_label.no_depth_test = true
	new_label.font_size = 50
	return new_label

func assign_hint_text(interactable: InteractableArea) -> Label3D:
	var new_hint = create_hint_text(interactable)
	interactable.add_child(new_hint)
	new_hint.global_position = ((interactable.global_position + PlayerManager.player.global_position) / 2) + HINT_OFFSET
	return new_hint
	
func deassign_hint_text(node: Node3D) -> void:
	var hint = node.get_node("HINT_TEXT")
	hint.queue_free()

func get_interaction_key(interactable : InteractableArea) -> String:
	var key_label = ""
	
	if interactable.can_hold:
		var left_hand_event := InputMap.action_get_events("left_hand")[0]
		var left_hand := left_hand_event.as_text()
		
		var right_hand_event := InputMap.action_get_events("right_hand")[0]
		var right_hand = right_hand_event.as_text()
		
		key_label = key_label + left_hand + "/" + right_hand
	
	if interactable.can_interact:
		var interact := InputMap.action_get_events("interact")[0]
		if interact is InputEventKey:
			key_label = key_label + "\n" + interact.as_text_physical_keycode()
		elif interact is InputEventMouseButton:
			key_label = key_label + "\n" + interact.as_text()
	
	return key_label
