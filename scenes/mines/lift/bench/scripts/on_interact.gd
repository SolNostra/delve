extends Node

@export var sit_marker : Marker3D

func _on_bench_interaction_area_interacted(being_interacted_with: bool) -> void:
	var player = PlayerManager.player
	var player_state = player.player_state
	
	if not being_interacted_with:
		player_state.set_player_state(PlayerStateComponent.PlayerState.BUSY)
		player.global_position = sit_marker.global_position
	else:
		player_state.set_player_state(PlayerStateComponent.PlayerState.IDLE)
	
	
