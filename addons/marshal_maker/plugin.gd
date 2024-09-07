@tool
extends EditorPlugin


var _ui: Control


func _enter_tree():
	_ui = preload("res://addons/marshal_maker/ui/BottomPanelUI.tscn").instantiate()
	
	var button = add_control_to_bottom_panel(_ui, 'MarshalMaker')
	button.shortcut_in_tooltip = true


func _exit_tree():
	remove_control_from_bottom_panel(_ui)
	_ui.free()
