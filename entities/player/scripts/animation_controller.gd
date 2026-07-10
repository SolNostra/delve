extends Node
class_name AnimationController

var player : Player
@export var player_state : PlayerStateComponent

@export var animation_tree : AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

func _process(_delta: float) -> void:
	if not player:
		player = PlayerManager.player
	
	update_walking_animation()

func update_walking_animation() -> void:
	var blend_value = 0.0
	if player_state.current_state == PlayerStateComponent.PlayerState.IDLE:
		blend_value = Vector2(player.velocity.x, player.velocity.z).length()
	elif player_state.current_state == PlayerStateComponent.PlayerState.BUSY:
		blend_value = 0.0
	
	animation_tree.set("parameters/moving/blend_position", blend_value)

func set_animation(animation: String, teleport: bool = false) -> void:
	state_machine.travel(animation, teleport)
