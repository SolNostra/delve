extends Control
class_name DebugManager

@onready var foldable = %FoldableContainer
@onready var player_state_label = %PlayerStateLabel

var player : Player

func _ready() -> void:
	foldable.fold()
	player = PlayerManager.player
	player.player_state.player_state_changed.connect(_on_player_state_changed)

func _on_player_state_changed(state: PlayerStateComponent.PlayerState) -> void:
	if state == 0:
		player_state_label.text = "Idle"
	elif state == 1: # holy chopped code
		player_state_label.text = "Busy"
