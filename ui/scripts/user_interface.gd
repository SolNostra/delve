extends CanvasLayer
class_name UserInterface

@onready var dialogue_manager: Node = %DialogueManager
@onready var fade_rect: FadeRect = %FadeRect

func _ready() -> void:
	fade_rect.fade_to_clear(1.0)
