## BottomPanelLogs
extends Control


@onready var _copy_button: Button = %CopyButton
@onready var _logs: TextEdit = %Logs


func set_logs(text: String) -> void:
	_logs.text = text


func _on_copy_button_pressed() -> void:
	DisplayServer.clipboard_set(_logs.text)
	_copy_button.text = " Copied! "

func _on_copy_timer_timeout() -> void:
	_copy_button.text = " Copy "


func _on_clear_button_pressed() -> void:
	_logs.text = ""
