class_name ASSimpleFieldDefaultConversionFactory


var _typename: String


func _init(typename: String):
	_typename = typename


func loader() -> String:
	match _typename:
		AS_TYPES.VECTOR_2: return "ASConversions.vector2_from_dict"
		AS_TYPES.VECTOR_3: return "ASConversions.vector3_from_dict"
	push_warning("No simple loader configured for type '", _typename, "'")
	return ""

func saver() -> String:
	match _typename:
		AS_TYPES.VECTOR_2: return "ASConversions.vector2_to_dict"
		AS_TYPES.VECTOR_3: return "ASConversions.vector3_to_dict"
	push_warning("No simple saver configured for type '", _typename, "'")
	return ""
