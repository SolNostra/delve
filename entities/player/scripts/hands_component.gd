extends Node
class_name HandsComponent

var left_hand_holding : HoldableItem = null
var right_hand_holding : HoldableItem = null

func place_in_left_hand(item: HoldableItem) -> void:
	if left_hand_holding != null:
		return # hand full! drop later?
	
	left_hand_holding = item
	item.holdable_component.pick_up()
	item.holdable_component.held_in = InteractionController.InteractedProperties.LeftHand

func drop_left_hand() -> void:
	if left_hand_holding == null:
		return
	
	left_hand_holding.holdable_component.put_down()
	left_hand_holding.holdable_component.held_in = InteractionController.InteractedProperties.Neither
	left_hand_holding = null

func place_in_right_hand(item: HoldableItem) -> void:
	if right_hand_holding != null:
		return # hand full! drop later?
	
	right_hand_holding = item
	item.holdable_component.pick_up()
	item.holdable_component.held_in = InteractionController.InteractedProperties.RightHand

func drop_right_hand() -> void:
	if right_hand_holding == null:
		return
	
	right_hand_holding.holdable_component.put_down()
	right_hand_holding.holdable_component.held_in = InteractionController.InteractedProperties.Neither
	right_hand_holding = null
