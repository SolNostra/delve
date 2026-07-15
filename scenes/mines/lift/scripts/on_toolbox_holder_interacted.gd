extends Node

const TOOLBOX = preload("uid://ddhvua1nwk3er")
var toolbox_exists := false

func spawn_toolbox() -> void:
	var new_toolbox := TOOLBOX.instantiate()
	get_tree().current_scene.add_child(new_toolbox)
	new_toolbox.global_position = get_parent().global_position
	
	toolbox_exists = true

func _on_toolbox_holder_interacted(properties) -> void:
	if properties == InteractionController.InteractedProperties.Neither \
	&& !toolbox_exists:
		spawn_toolbox()
