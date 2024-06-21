class_name ASArrayLib


static func get_at(array: Array, index: int, default = null):
	if array.size() <= index:
		return default
	return array[index]
