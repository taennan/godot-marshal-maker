class_name MMSimpleFieldDefaultConversionFactory


var _typename: String


func _init(typename: String):
	_typename = typename


func loader() -> String:
	match _typename:
		MM_TYPES.VECTOR_2: return "MMConversions.vector2_from_dict"
		MM_TYPES.VECTOR_3: return "MMConversions.vector3_from_dict"
	
	if _typename in MM_TYPES.RESOURCE:
		return "load"
	
	push_warning("No simple loader configured for type '", _typename, "'")
	return ""


func saver() -> String:
	match _typename:
		MM_TYPES.VECTOR_2: return "MMConversions.vector2_to_dict"
		MM_TYPES.VECTOR_3: return "MMConversions.vector3_to_dict"
	
	if _typename in MM_TYPES.RESOURCE:
		return "MMConversions.resource_to_string"
	
	push_warning("No simple saver configured for type '", _typename, "'")
	return ""
