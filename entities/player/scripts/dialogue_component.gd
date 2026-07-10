extends Node
class_name DialogueComponent

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_started(_dialogue: DialogueResource) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	PlayerManager.player.player_state_component.current_state = PlayerStateComponent.PlayerState.BUSY

func _on_dialogue_ended(_dialogue: DialogueResource) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	PlayerManager.player.player_state_component.current_state = PlayerStateComponent.PlayerState.IDLE
