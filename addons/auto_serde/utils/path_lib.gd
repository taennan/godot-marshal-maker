class_name ASPathLib


const PATH_SEPERATOR := "/"


static func join(a: String, b: String) -> String:
	return _strip_path_seperators(a) + PATH_SEPERATOR + _strip_path_seperators(b)


static func _strip_path_seperators(path: String) -> String:
	return path.lstrip(PATH_SEPERATOR).rstrip(PATH_SEPERATOR)
