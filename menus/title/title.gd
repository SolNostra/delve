extends Control
class_name TitleMenu

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home/home.tscn")

func _on_options_button_pressed() -> void:
	pass # go 2 options when made

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	# do something funny with this later
