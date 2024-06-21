class_name ASFileScout


var _root_dirpath := "res://"
var _ignored_dirpaths: Array[String] = []


func _init(root_dirpath := "res://", ignored_dirpaths: Array[String] = []):
	_root_dirpath = root_dirpath
	_ignored_dirpaths = ignored_dirpaths


# NOTE: Abstract method
func get_filepaths() -> Array[String]:
	return []
