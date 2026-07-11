extends ProgressBar

@onready var full_label: RichTextLabel = %FullLabel

func _ready() -> void:
	AzureManager.azure_progress_changed.connect(_on_azure_progress_changed)
	AzureManager.azure_filled.connect(_on_azure_filled) 
	
func _on_azure_progress_changed(new_value: float) -> void:
	value = new_value

func _on_azure_filled() -> void:
	full_label.show()
