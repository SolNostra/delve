extends Area3D

@export var anim_player : AnimationPlayer

func _ready() -> void:
	anim_player.play("door_close", 0.8)

func _on_body_entered(_body: Node3D) -> void:
	anim_player.play("door_open",0.8)

func _on_body_exited(_body: Node3D) -> void:
	anim_player.play("door_close", 0.8)
