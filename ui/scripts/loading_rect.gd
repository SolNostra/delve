extends ColorRect
class_name LoadingScreen

@onready var fade_rect: FadeRect = %FadeRect
@onready var progress_bar: ProgressBar = %ProgressBar

@export var minimum_loading_time := 1.0
var elapsed := 0.0

@export var next_scene_path: String = "res://scenes/hub/hub_area.tscn"
var progress : Array[float] = []
signal scene_loaded

var changing_scene := false

func _ready() -> void:
	fade_rect.fade_to_clear(0.5)
	ResourceLoader.load_threaded_request(next_scene_path)

func _process(delta: float) -> void:
	var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	elapsed += delta
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var pct = progress[0] * 100
			progress_bar.value = pct
		ResourceLoader.THREAD_LOAD_LOADED:
			if changing_scene:
				return
			
			if elapsed < minimum_loading_time:
				return
			
			changing_scene = true
			set_process(false)
			
			var scene = ResourceLoader.load_threaded_get(next_scene_path) as PackedScene
			await fade_rect.fade_to_black(0.5)
			
			var err = get_tree().change_scene_to_packed(scene)
			if err:
				push_error(err)
			
			scene_loaded.emit()
			queue_free()
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			push_error("Failed to load scene: " + next_scene_path)
			queue_free()
