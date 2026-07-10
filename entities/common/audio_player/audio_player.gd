extends AudioStreamPlayer3D
class_name audio_player

var tween : Tween

func fade_in(duration: float = 1.0, target_db: float = 0.0):
	play()
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "volume_db", target_db, duration)

func fade_out(duration: float = 1.0,):
	if tween: 
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "volume_db", -80.0, duration)
	tween.tween_callback(stop)
