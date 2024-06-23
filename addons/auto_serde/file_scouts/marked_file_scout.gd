class_name ASMarkedFileScout
extends ASFileScout


func get_filepaths() -> Array[String]:
	var recursive_files := ASRecursiveFileScout.new(_root_dirpath, _ignored_paths).get_filepaths()
	var marked_files := recursive_files.filter(_is_file_marked_for_auto_serde)
	return marked_files

func _is_file_marked_for_auto_serde(filepath: String) -> bool:
	if not _is_gdscript_file(filepath):
		return false
	return ASFileLineIterator.new(filepath).has_line(_is_line_auto_serde_directive)

func _is_gdscript_file(filepath: String) -> bool:
	return filepath.ends_with(".gd") and FileAccess.file_exists(filepath)

func _is_line_auto_serde_directive(line: String) -> bool:
	var directive := ASDirectiveTokens.new(line)
	return not directive.error() and directive.targets_outer()
