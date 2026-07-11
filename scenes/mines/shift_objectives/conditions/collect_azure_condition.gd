extends ObjectiveCondition
class_name CollectAzureCondition

func setup_objective() -> void:
	AzureManager.azure_filled.connect(_on_azure_filled)

func _on_azure_filled() -> void:
	fulfill_objective()
