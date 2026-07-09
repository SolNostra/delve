extends Node
class_name PlayerStateComponent

enum PlayerState {
	IDLE,
	BUSY,
}

var current_state := PlayerState.IDLE
signal player_state_changed(new_state: PlayerState)

func set_player_state(new_state: PlayerState) -> void:
	current_state = new_state
	player_state_changed.emit(new_state)

func is_player_state(state_to_check: PlayerState) -> bool:
	return current_state == state_to_check
