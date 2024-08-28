@tool

## BottomPanelDirectories
extends Control


@onready var _out_dir_input = %OutDirInput
@onready var _in_dir_input = %InDirsBox
@onready var _mod_in_dir_button: Button = %ModInDirButton


func has_out_dir() -> bool:
	return out_dir() != ""

func out_dir() -> String:
	return _out_dir_input.value().strip_edges()


func has_in_dir() -> bool:
	return in_dir() != ""

func in_dir() -> String:
	return _in_dir_input.value().strip_edges()
