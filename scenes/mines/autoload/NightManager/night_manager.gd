extends Node

signal night_started()
signal night_ended()

func start_night() -> void:
	night_started.emit()

func end_night() -> void:
	night_ended.emit()
