class_name MMArrLib


static func get_at(array: Array, index: int, default = null):
	if array.size() <= index:
		return default
	return array[index]

static func back(array: Array, default = null):
	var size := array.size()
	if size == 0:
		return default
	return array[size - 1]

static func set_at(array: Array, index: int, value) -> void:
	if index < array.size():
		array[index] = value

static func append_unique(array: Array, item) -> void:
	if not item in array:
		array.append(item)
