extends Node
class_name DialogueComponent

const Balloon = preload("res://ui/assets/dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _input(event: InputEvent) -> void:
	pass
	
func test_dialogue() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var balloon := Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
