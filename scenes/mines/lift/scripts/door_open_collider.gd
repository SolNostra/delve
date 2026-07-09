extends Area3D

@export var anim_player : AnimationPlayer

func _ready() -> void:
	anim_player.play_section_backwards("DoorOpen", 0, 0.8)

func _on_body_entered(body: Node3D) -> void:
	anim_player.play("DoorOpen")

func _on_body_exited(body: Node3D) -> void:
	anim_player.play_section_backwards("DoorOpen", 0, 0.8)
