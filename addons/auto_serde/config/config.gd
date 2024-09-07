class_name AutoSerdConfig
extends Resource


const PLUGIN_CONFIG_PATH := "res://addons/auto_serde/config/config.tres"

@export var input_directory := ""
@export var output_directory := ""
@export var ignored_paths: Array[String] = []


static func plugin_config() -> AutoSerdConfig:
	var config = load(PLUGIN_CONFIG_PATH)
	return config if config is AutoSerdConfig else null


func save_as_plugin_config() -> void:
	ResourceSaver.save(self, PLUGIN_CONFIG_PATH)
