@tool

## MMDirectoryInput
extends Control


signal value_changed(new_value: String)


@onready var _file_dialog: FileDialog = %FileDialog
@onready var _line_edit: LineEdit = %LineEdit
@onready var _select_dir_button: Button = %SelectDirButton


func value() -> String:
	return _line_edit.text

func set_value(new_value: String) -> void:
	_line_edit.text = new_value


func _on_select_dir_button_pressed() -> void:
	_file_dialog.show()

func _on_file_dialog_dir_selected(directory: String):
	_line_edit.text = directory
	value_changed.emit(directory)
