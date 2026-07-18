extends Node

signal azure_progress_changed(new_value: int)
signal azure_filled()

var current_azure := 0
var max_azure := 100

var current_drill : AzureDrill
	
func set_progress(value: int) -> void:
	current_azure = clampi(value, 0, max_azure)
	azure_progress_changed.emit(current_azure)
	check_finished()

func add_progress(value: int) -> void:
	current_azure = clampi(current_azure + value, 0, max_azure)
	azure_progress_changed.emit(current_azure)
	check_finished()

func check_finished() -> void:
	if current_azure >= max_azure:
		finished()

func finished() -> void:
	azure_filled.emit()
