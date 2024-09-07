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
	var config := AutoSerdeConfig.plugin_config()
	if not config:
		_logs.add_log("ERROR: No plugin config found at " + AutoSerdeConfig.PLUGIN_CONFIG_PATH)
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
	runner.created_temp_outdir.connect(_on_runner_created_temp_outdir)
	runner.marked_file_found.connect(_on_runner_marked_file_found)
	runner.saver_written.connect(_on_runner_saver_written)
	runner.loader_written.connect(_on_runner_loader_written)
	runner.deleted_temp_outdir.connect(_on_runner_deleted_temp_outdir)
	runner.go()
	
	_logs.add_log("Done!")

func _on_runner_created_temp_outdir() -> void:
	_logs.add_log("Created backup outdir")

func _on_runner_marked_file_found(filepath: String) -> void:
	_logs.add_log("Found auto_serde file: " + filepath)

func _on_runner_saver_written(typename: String) -> void:
	_logs.add_log("Wrote saver for: " + typename)

func _on_runner_loader_written(typename: String) -> void:
	_logs.add_log("Wrote loader for: " + typename)

func _on_runner_deleted_temp_outdir() -> void:
	_logs.add_log("Deleted backup outdir")


func _on_directories_input_directory_changed(_new_value: String) -> void:
	_update_config()

func _on_directories_output_directory_changed(_new_value: String) -> void:
	_update_config()

func _update_config() -> void:
	var config := AutoSerdeConfig.new()
	config.input_directory = _directories.in_dir()
	config.output_directory = _directories.out_dir()
	config.ignored_paths = []
	config.save_as_plugin_config()
