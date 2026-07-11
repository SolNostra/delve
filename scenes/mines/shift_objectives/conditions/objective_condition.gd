extends Resource
class_name ObjectiveCondition

signal objective_fulfilled(objective: Objective)

## To be overwritten
func setup_objective() -> void:
	pass
	
func fulfill_objective() -> void:
	objective_fulfilled.emit()
