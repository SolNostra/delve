extends Control
class_name DebugManager

@onready var foldable = %FoldableContainer

@onready var stat_selection: OptionButton = %StatSelection
@onready var modify_value: LineEdit = %ModifyValue

var player : Player

func _ready() -> void:
	foldable.fold()
	player = PlayerManager.player

func _on_modify_confirm_button_pressed() -> void:
	if stat_selection.selected == 0:
		player.health_component.increase(modify_value.text.to_int())
