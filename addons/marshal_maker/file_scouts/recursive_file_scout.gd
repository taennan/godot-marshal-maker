class_name MMRecursiveFileScout
extends MMFileScout


func get_filepaths() -> Array[String]:
	return _get_filepaths_recursively(_root_dirpath)

func _get_filepaths_recursively(path: String) -> Array[String]:
	if _ignores(path):
		return []
	
	var files_and_dirs_MMResult := _get_files_and_dirs_in_dir(path)
	if files_and_dirs_MMResult.is_error:
		push_error("An error occurred when trying to access the path '" + path + "'")
		return []
	
	var MMResult: Array[String] = files_and_dirs_MMResult.filepaths
	for dirpath in files_and_dirs_MMResult.dirpaths:
		var subfilepaths := _get_filepaths_recursively(dirpath)
		MMResult.append_array(subfilepaths)
	
	return MMResult

func _get_files_and_dirs_in_dir(path: String) -> _GetFilesAndDirsInDirMMResult:
	var dir = DirAccess.open(path)
	if not dir:
		var MMResult := _GetFilesAndDirsInDirMMResult.new()
		MMResult.is_error = true
		return MMResult
	
	var dirpaths: Array[String] = []
	var filepaths: Array[String] = []
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		
		var fullpath := MMPathLib.join(path, file_name)
		var not_ignored := not _ignores(fullpath)
		var is_dir := dir.current_is_dir()
		
		if is_dir and not_ignored:
			dirpaths.append(fullpath)
		elif not is_dir and not_ignored:
			filepaths.append(fullpath)
		
		file_name = dir.get_next()
	
	var MMResult := _GetFilesAndDirsInDirMMResult.new()
	MMResult.filepaths = filepaths
	MMResult.dirpaths = dirpaths
	return MMResult

class _GetFilesAndDirsInDirMMResult:
	var is_error := false
	var dirpaths: Array[String] = []
	var filepaths: Array[String] = []
