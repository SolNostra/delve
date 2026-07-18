extends Node3D
class_name AzureDrill

## Mechanics
@export var progress_per_tick := 1
@export var tick_duration := 1.0
signal drill_ticked()

## FX
@onready var drilling_sfx: audio_player = $DrillingSFX
@onready var beep_sfx: audio_player = $BeepSFX
@onready var particles_emitter: GPUParticles3D = $ParticlesEmitter
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var progress_timer: Timer = $ProgressTimer

var can_drill := true
var finished_drilling := false
var drilling := false

func _ready() -> void:
	AzureManager.current_drill = self
	AzureManager.azure_filled.connect(_on_azure_filled)
	_connect_to_drill_nodes()

func _connect_to_drill_nodes() -> void:
	var drill_nodes = get_tree().current_scene.find_children("*", "DrillNode", true)
	for drill_node: DrillNode in drill_nodes:
		drill_node.connect_to_drill(self)

func _on_interactable_area_interacted(properties: InteractionController.InteractedProperties) -> void:
	if properties != InteractionController.InteractedProperties.Neither:
		return
	
	if drilling:
		stop_drilling()
	else:
		start_drilling()
	
func start_drilling() -> void:
	if !can_drill or finished_drilling:
		return
	
	drilling = true
	drilling_sfx.fade_in(2, -15)
	beep_sfx.play()
	
	await get_tree().create_timer(1.5).timeout
	progress_timer.start(tick_duration)
	particles_emitter.emitting = true

func stop_drilling() -> void:
	drilling = false
	drilling_sfx.fade_out(2)
	beep_sfx.play()
	
	particles_emitter.emitting = false
	progress_timer.stop()

func _on_progress_timer_timeout() -> void:
	AzureManager.add_progress(progress_per_tick)
	drill_ticked.emit()

func _on_azure_filled() -> void:
	stop_drilling()
	finished_drilling = true
