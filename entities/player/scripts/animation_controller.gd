extends Node
class_name AnimationController

@export var animation_tree : AnimationTree
@export var player_state : PlayerStateComponent

var player : Player

func _process(delta: float) -> void:
	if not player:
		player = PlayerManager.player
	
	update_walking_animation()

func update_walking_animation() -> void:
	if player_state.current_state == PlayerStateComponent.PlayerState.IDLE:
		var blend_value := Vector2(player.velocity.x, player.velocity.z).length()
		animation_tree.set("parameters/blend_position", blend_value)

func set_sitting_animation(sitting: bool) -> void:
	pass # remove later
