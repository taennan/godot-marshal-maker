class_name ASUniqueFilenameFactory


var _dirpath: String


func _init(dirpath: String):
	_dirpath = dirpath


func unique_name_ending_with(string: String) -> String:
	var filenames := _get_files_and_dirs_in_dir()
	var unique_name := str(randi_range(100_000, 999_999)) + string
	if unique_name in filenames:
		return unique_name_ending_with(string)
	return unique_name

func _get_files_and_dirs_in_dir() -> Array[String]:
	var dir := DirAccess.open(_dirpath)
	if not dir:
		push_error("Can't find directory '", _dirpath, "'")
		return []
	
	var names: Array[String] = []
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		names.append(file_name)
		file_name = dir.get_next()
	
	return names
