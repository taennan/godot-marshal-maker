class_name MMFileScout


var _root_dirpath := "res://"
var _ignored_paths: Array[String] = []


func _init(root_dirpath := "res://", ignored_paths: Array[String] = []):
	_root_dirpath = root_dirpath
	_ignored_paths = ignored_paths


func _ignores(path: String) -> bool:
	return path in _ignored_paths

# NOTE: Abstract method
func get_filepaths() -> Array[String]:
	return []
