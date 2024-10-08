class_name MMWriterContext


var _objects: Array[MMObjectTokens] = []
var _writable_types: Array[String] = []


func marshal_maker_version() -> String:
	return "v0.0.0"


func object_tokens() -> Array[MMObjectTokens]:
	return _objects

func add_object_tokens(object_tokens: MMObjectTokens) -> void:
	if not has_object_of_type(object_tokens.type()):
		_objects.append(object_tokens)

func has_object_of_type(type: String) -> bool:
	for object in _objects:
		if object.type() == type:
			return true
	return false


func is_writable_type(type: String) -> bool:
	return type in _writable_types

func add_writable_type(type: String) -> void:
	MMArrLib.append_unique(_writable_types, type)
