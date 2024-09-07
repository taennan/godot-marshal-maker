@tool

## BottomPanelUI
extends Control


@onready var _actions = %Actions
@onready var _directories = %Directories
@onready var _logs = %Logs


func _ready() -> void:
	_logs.set_logs("")
	_load_config()

func _load_config() -> void:
	var config := AutoSerdConfig.plugin_config()
	if not config:
		_logs.add_log("ERROR: No plugin config found at " + AutoSerdConfig.PLUGIN_CONFIG_PATH)
		return
	
	_directories.update_from_config(config)


func _on_actions_generate() -> void:
	if not _is_directory_inputs_valid():
		_logs.add_log("ERROR: Must choose an input and output directory")
		return
	
	_generate_files()

func _is_directory_inputs_valid() -> bool:
	return _directories.has_in_dir() and _directories.has_out_dir()

func _generate_files() -> void:
	var runner := ASWriterRunner.new(_directories.in_dir(), _directories.out_dir())
	runner.go()


func _on_directories_input_directory_changed(_new_value: String) -> void:
	_update_config()

func _on_directories_output_directory_changed(_new_value: String) -> void:
	_update_config()

func _update_config() -> void:
	var config := AutoSerdConfig.new()
	config.input_directory = _directories.in_dir()
	config.output_directory = _directories.out_dir()
	config.ignored_paths = []
	config.save_as_plugin_config()
