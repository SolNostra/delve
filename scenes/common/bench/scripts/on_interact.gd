extends Node

var sit_marker : Marker3D

func _ready() -> void:
	sit_marker = owner.find_children("*", "Marker3D", false).front()
	if !sit_marker:
		printerr("Unable to identify sitting marker for seating area on object: ", owner)

func _on_bench_interaction_area_interacted(being_interacted_with: bool) -> void:
	var player = PlayerManager.player
	var player_state = player.player_state
	
	if not being_interacted_with:
		player_state.set_player_state(PlayerStateComponent.PlayerState.BUSY)
		player.model.rotation = sit_marker.rotation
		player.global_position = sit_marker.global_position
		player.animation_controller.set_animation("sitting")
	else:
		player_state.set_player_state(PlayerStateComponent.PlayerState.IDLE)
		player.animation_controller.set_animation("moving")
		

# Move the camera off the player to an external POV?
	
