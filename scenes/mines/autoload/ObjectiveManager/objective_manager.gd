extends Node

signal objective_created(objective)
const objectives_folder := "res://scenes/mines/shift_objectives/"

func _ready() -> void:
	NightManager.night_started.connect(_on_night_started)

func _on_night_started() -> void:
	load_objectives(1) # Later, check the save data to see what night we are on.

func load_objectives(shift: int) -> void:
	var target_path = objectives_folder + str(shift)
	var files = DirAccess.get_files_at(target_path)
	for file in files:
		var full_path = target_path + '/' + file
		if ResourceLoader.exists(full_path):
			var objective = load(full_path) as Objective
			if objective:
				create_objective(objective)
			else:
				push_warning("Skipping non-Objective file: " + full_path)
		

func create_objective(objective: Objective) -> void:
	objective_created.emit(objective)
