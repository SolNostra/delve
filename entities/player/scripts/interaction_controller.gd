extends Node
class_name InteractionController

@onready var player_state_component: PlayerStateComponent = %PlayerStateComponent

	
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
	if event.is_action_pressed("interact") \
	and PlayerManager.player.player_state_component.current_state != PlayerStateComponent.PlayerState.BUSY:
		for interactable in interactables_nearby:
			interactable.interact()

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
func create_hint_text() -> Label3D:
	var new_label = Label3D.new()
	new_label.name = "HINT_TEXT"
	new_label.text = get_interaction_key()
	new_label.billboard = true
	new_label.no_depth_test = true
	new_label.font_size = 50
	return new_label

func assign_hint_text(node: Node3D) -> Label3D:
	var new_hint = create_hint_text()
	node.add_child(new_hint)
	new_hint.global_position = ((node.global_position + PlayerManager.player.global_position) / 2) + HINT_OFFSET
	return new_hint
	
func deassign_hint_text(node: Node3D) -> void:
	var hint = node.get_node("HINT_TEXT")
	hint.queue_free()

func get_interaction_key() -> String:
	var event : InputEventKey = InputMap.action_get_events("interact")[0]
	var key_label = event.as_text_physical_keycode()
	return key_label
