class_name ASMarkedFileScout
extends ASFileScout


func get_filepaths() -> Array[String]:
	var recursive_files := ASRecursiveFileScout.new(_root_dirpath, _ignored_paths).get_filepaths()
	var marked_files := recursive_files.filter(_is_file_marked_for_auto_serde)
	return marked_files

func _is_file_marked_for_auto_serde(filepath: String) -> bool:
	var file := FileAccess.open(filepath, FileAccess.READ)
	var file_length := file.get_length()
	
	while file.get_position() < file_length:
		var line := file.get_line()
		var directive := ASDirectiveTokens.new(line)
		if not directive.error and directive.targets_outer:
			return true
	
	return false
