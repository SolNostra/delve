extends Node3D

## Mechanics
@export var progress_per_tick := 1
@export var tick_duration := 1.0

## Visuals
@onready var audio_player: audio_player = $AudioPlayer
@onready var particles_emitter: GPUParticles3D = $ParticlesEmitter
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var progress_timer: Timer = $ProgressTimer

var drilling := false

func _on_interactable_area_interacted() -> void:
	if drilling:
		stop_drilling()
	else:
		start_drilling()
	
func start_drilling() -> void:
	drilling = true
	audio_player.fade_in(2, -15)
	await get_tree().create_timer(1.5).timeout
	particles_emitter.emitting = true
	progress_timer.start(tick_duration)

func stop_drilling() -> void:
	particles_emitter.emitting = false
	drilling = false
	audio_player.fade_out(2)
	progress_timer.stop()

func _on_progress_timer_timeout() -> void:
	NightManager.add_progress(progress_per_tick)
