extends InteractableArea
class_name DialogueInteractable
## An interactable area that shows dialogue when interacted with.

const Balloon = preload("res://ui/assets/dialogue/balloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	super()
	interacted.connect(_show_dialogue)

func _show_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource)
