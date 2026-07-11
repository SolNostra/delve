extends Panel
class_name ObjectivesPanel

@onready var objectives_container: VBoxContainer = $MarginContainer/ObjectivesContainer

func _ready() -> void:
	ObjectiveManager.objective_created.connect(_on_objective_created)

func _on_objective_created(objective: Objective) -> void:
	var objective_label = Label.new()
	objectives_container.add_child(objective_label)
	
	objective_label.name = objective.objective_id
	objective_label.text = objective.objective_title + " - Incomplete"
	objective_label.custom_minimum_size = Vector2(0, 20)
	objective_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	objective.objective_condition.setup_objective()
	objective.objective_condition.objective_fulfilled.connect(_on_objective_fulfilled.bind(objective))

func _on_objective_fulfilled(objective: Objective) -> void:
	for obj in objectives_container.get_children():
		if obj is Label && obj.name == objective.objective_id:
				obj.text = objective.objective_title + " - Complete"
