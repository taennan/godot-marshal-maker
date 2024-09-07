@tool

## BottomPanelActions
extends Control


signal generate


func _on_run_button_pressed() -> void:
	generate.emit()
