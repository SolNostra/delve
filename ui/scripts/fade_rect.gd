extends ColorRect
class_name FadeRect

func fade_to_clear(duration: float) -> void:
	color.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "color:a", 0.0, duration)

func fade_to_black(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "color:a", 1.0, duration)
	await tween.finished
	
