class_name MMMarkedFileScout
extends MMFileScout


func get_filepaths() -> Array[String]:
	var recursive_files := MMRecursiveFileScout.new(_root_dirpath, _ignored_paths).get_filepaths()
	var marked_files := recursive_files.filter(_is_file_marked_for_marshal_maker)
	return marked_files

func _is_file_marked_for_marshal_maker(filepath: String) -> bool:
	if not _is_gdscript_file(filepath):
		return false
	return MMFileLineIterator.new(filepath).has_line(_is_line_marshal_maker_directive)

func _is_gdscript_file(filepath: String) -> bool:
	return filepath.ends_with(".gd") and FileAccess.file_exists(filepath)

func _is_line_marshal_maker_directive(line: String) -> bool:
	var directive := MMDirectiveTokens.new(line)
	return not directive.error() and directive.targets_outer()
