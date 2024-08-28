@tool

## BottomPanelDirectories
extends Control


@onready var _out_dir_input = %OutDirInput
@onready var _in_dirs_box: Control = %InDirsBox
@onready var _mod_in_dir_button: Button = %ModInDirButton


func has_out_dir() -> bool:
	return out_dir() != ""

func out_dir() -> String:
	return _out_dir_input.value()


func has_in_dirs() -> bool:
	return in_dirs().size() > 0

func in_dirs() -> Array[String]:
	var result: Array[String] = []
	for child in _in_dirs_box.get_children():
		var in_dir: String = child.value()
		if in_dir:
			result.append(in_dir)
	
	return result


func _on_add_dir_button_pressed() -> void:
	const DIRECTORY_INPUT := preload("res://addons/auto_serde/ui/directory_input/DirectoryInput.tscn")
	var scene := DIRECTORY_INPUT.instantiate()
	_in_dirs_box.add_child(scene)


func _on_clear_dir_input_pressed() -> void:
	pass
