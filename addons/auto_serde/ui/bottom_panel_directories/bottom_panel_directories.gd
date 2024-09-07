@tool

## BottomPanelDirectories
extends Control


signal input_directory_changed(new_value: String)
signal output_directory_changed(new_value: String)


@onready var _out_dir_input = %OutDirInput
@onready var _in_dir_input = %InDirInput



func update_from_config(config: AutoSerdeConfig) -> void:
	_in_dir_input.set_value(config.input_directory)
	_out_dir_input.set_value(config.output_directory)


func has_out_dir() -> bool:
	return out_dir() != ""

func out_dir() -> String:
	return _out_dir_input.value().strip_edges()


func has_in_dir() -> bool:
	return in_dir() != ""

func in_dir() -> String:
	return _in_dir_input.value().strip_edges()


func _on_out_dir_input_value_changed(new_value: String) -> void:
	output_directory_changed.emit(new_value)

func _on_in_dir_input_value_changed(new_value: String) -> void:
	input_directory_changed.emit(new_value)
