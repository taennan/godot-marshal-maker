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
