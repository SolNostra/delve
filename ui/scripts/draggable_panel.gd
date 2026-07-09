extends Panel
class_name DraggablePanel

var dragging := false
var offset := Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("drag_window"):
			dragging = true
			offset = get_global_mouse_position() - global_position
		else:
			dragging = false
	
	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - offset
