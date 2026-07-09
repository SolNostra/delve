extends Node

var last_death_type : String

func enter_death_screen(death_type: String) -> void:
	last_death_type = death_type
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await get_tree().physics_frame
	get_tree().change_scene_to_file("res://menus/dead/dead_menu.tscn")
