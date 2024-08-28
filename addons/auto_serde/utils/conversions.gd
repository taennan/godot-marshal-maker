class_name ASConversions


static func vector2_from_dict(dict: Dictionary) -> Vector2:
	var x := dict.get("x")
	var y := dict.get("y")
	return Vector2(x, y)

static func vector2_to_dict(vector: Vector2) -> Dictionary:
	return {
		"x": vector.x,
		"y": vector.y
	}


static func vector2_from_array(array: Array) -> Vector2:
	const default_value := 0.0
	var x: float = ASArrLib.get_at(array, 0, default_value)
	var y: float = ASArrLib.get_at(array, 1, default_value)
	return Vector2(x, y)

static func vector2_to_array(vector: Vector2) -> Array:
	return [vector.x, vector.y]
