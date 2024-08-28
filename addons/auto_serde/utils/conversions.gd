class_name ASConversions


static func vector2_from_dict(dict: Dictionary) -> Vector2:
	const default_value := 0.0
	var x: float = dict.get("x", default_value)
	var y: float = dict.get("y", default_value)
	return Vector2(x, y)

static func vector2_to_dict(vector: Vector2) -> Dictionary:
	return {
		"x": vector.x,
		"y": vector.y
	}


static func vector2_from_array(array: Array[float]) -> Vector2:
	const default_value := 0.0
	var x: float = ASArrLib.get_at(array, 0, default_value)
	var y: float = ASArrLib.get_at(array, 1, default_value)
	return Vector2(x, y)

static func vector2_to_array(vector: Vector2) -> Array[float]:
	return [vector.x, vector.y]


static func vector3_from_dict(dict: Dictionary) -> Vector3:
	const default_value := 0.0
	var x: float = dict.get("x", default_value)
	var y: float = dict.get("y", default_value)
	var z: float = dict.get("z", default_value)
	return Vector3(x, y, z)

static func vector3_to_dict(vector: Vector3) -> Dictionary:
	return {
		"x": vector.x,
		"y": vector.y,
		"z": vector.z
	}


static func vector3_from_array(array: Array[float]) -> Vector3:
	const default_value := 0.0
	var x: float = ASArrLib.get_at(array, 0, default_value)
	var y: float = ASArrLib.get_at(array, 1, default_value)
	var z: float = ASArrLib.get_at(array, 2, default_value)
	return Vector3(x, y, z)

static func vector3_to_array(vector: Vector3) -> Array[float]:
	return [vector.x, vector.y, vector.z]
