extends Area3D
class_name InteractableArea

signal interacted(interaction_state: bool)

var player_in_area := false ## Is the player currently in the objects interaction radius?
var is_interacted := false ## Is the object currently being interacted with?

func on_interactible_area_entered() -> void:
	player_in_area = true

func on_interactible_area_exited() -> void:
	player_in_area = false

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("interact"):
		return
		
	if !player_in_area: # wow this is poorly coded but who cares really, it's not like anyone will see this :eyes:
		return
	
	is_interacted = !is_interacted
	interacted.emit(is_interacted)
	
