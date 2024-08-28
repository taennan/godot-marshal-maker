@tool

## ASDirectoryInput
extends Control


@onready var _file_dialog: FileDialog = %FileDialog
@onready var _label: Label = %Label
@onready var _line_edit: LineEdit = %LineEdit
@onready var _select_dir_button: Button = %SelectDirButton


func set_label(text: String) -> void:
	_label.text = text

func value() -> String:
	return _line_edit.text


func _on_select_dir_button_pressed() -> void:
	_file_dialog.show()
