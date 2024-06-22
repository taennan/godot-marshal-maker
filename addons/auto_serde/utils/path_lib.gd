class_name ASPathLib


const PATH_SEPERATOR := "/"


static func parent(path: String) -> String:
	var segments := path.split(PATH_SEPERATOR, false)
	if segments.size() <= 1:
		return path
	return PATH_SEPERATOR.join(segments.slice(0, -1))

static func name(path: String) -> String:
	var segments := path.split(PATH_SEPERATOR, false)
	return ASArrLib.back(segments, "")

static func join(a: String, b: String) -> String:
	return _strip_path_seperators(a) + PATH_SEPERATOR + _strip_path_seperators(b)

static func _strip_path_seperators(path: String) -> String:
	return path.lstrip(PATH_SEPERATOR).rstrip(PATH_SEPERATOR)
