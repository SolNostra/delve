extends Node3D

@onready var audio_player: audio_player = $AudioPlayer
@onready var sparks_emitter: GPUParticles3D = $SparksEmitter
@onready var animation_tree: AnimationTree = $AnimationTree

var drilling := false

func _on_interactable_area_interacted(interaction_state: bool) -> void:
	if drilling:
		stop_drilling()
	else:
		start_drilling()
	
func start_drilling() -> void:
	drilling = true
	sparks_emitter.emitting = true
	audio_player.fade_in(2, -15)

func stop_drilling() -> void:
	sparks_emitter.emitting = false
	drilling = false
	audio_player.fade_out(2)
