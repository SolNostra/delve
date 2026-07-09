extends Control
class_name PauseMenu

var paused : bool
signal pause_state_changed(state: bool)

func _on_resume_button_pressed() -> void:
	toggle_pause()

func _on_options_button_pressed() -> void:
	toggle_pause()
	# show options later

func _on_quit_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = false
	
	get_tree().change_scene_to_file("res://menus/title/title.tscn")
	
func toggle_pause() -> void:
		paused = !paused
		if paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
			show()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false
			hide()
		
		emit_signal("pause_state_changed", paused)
