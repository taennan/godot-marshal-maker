class_name ASSerdeFieldConversionFactory


var _field_data: ASObjectTokensFieldData
var _context: ASWriterContext


func _init(field_data: ASObjectTokensFieldData, context: ASWriterContext):
	_field_data = field_data
	_context = context


func make() -> String:
	if _is_field_ignored():
		return ""
	
	if is_field_primitive():    return _get_primitive_conversion()
	if is_field_simple_array(): return _get_simple_array_conversion()
	if is_field_simple():       return _get_simple_conversion()
	if is_field_serde_array():  return _get_serde_array_conversion()
	if is_field_serde_object(): return _get_serde_conversion()
	
	push_error(
		"Couldn't decide how to convert field '", 
		_field_data.field().name(),
		"' of type '",
		_field_data.field().type(),
		"'"
	)
	return ""


func _is_field_ignored() -> bool:
	var has_directive := _field_data.directive() != null
	var has_ignore_directive := has_directive and _field_data.directive().ignore()
	var is_directiveless_normal_var := not has_directive and not _field_data.field().is_export()
	
	return has_ignore_directive or is_directiveless_normal_var


func is_field_primitive() -> bool:
	return _field_data.field().type() in AS_TYPES.PRIMITIVE

func is_field_simple_array() -> bool:
	return _field_data.field().is_array() and is_field_simple()

func is_field_simple() -> bool:
	return _field_data.field().type() in AS_TYPES.SIMPLE

func is_field_serde_array() -> bool:
	return _field_data.field().is_array() and is_field_serde_object()

func is_field_serde_object() -> bool:
	return _context.has_object_of_type(_field_data.field().type())


func _get_primitive_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_primitive_conversion method is meant to be overridden")
	return ""

func _get_simple_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_simple_conversion method is meant to be overridden")
	return ""

func _get_simple_array_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_simple_array_conversion method is meant to be overridden")
	return ""

func _get_serde_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_serde_conversion method is meant to be overridden")
	return ""

func _get_serde_array_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_serde_array_conversion method is meant to be overridden")
	return ""


func _formatting_data() -> Dictionary:
	var save_with := _get_save_with_prefix()
	var load_with := _get_load_with_prefix()
	var has_custom_saver := save_with.strip_edges() != ""
	var has_custom_loader := load_with.strip_edges() != ""
	
	var result := {
		"name": _field_data.field().name(),
		"type": _field_data.field().type(),
		"saved_name": _saved_name(),
		"save_with_prefix": save_with + "(" if has_custom_saver else "",
		"save_with_suffix": ")" if has_custom_saver else "",
		"load_with_prefix": load_with + "(" if has_custom_loader else "",
		"load_with_suffix": ")" if has_custom_loader else "",
	}
	return result

func _saved_name() -> String:
	var directive := _field_data.directive()
	if directive and directive.rename():
		return directive.rename()
	
	var base_name := _field_data.field().name()
	return base_name

func _get_load_with_prefix() -> String:
	var directive := _field_data.directive()
	var load_with := directive.load_with() if directive else ""
	
	if not load_with and is_field_simple():
		var typename := _field_data.field().type()
		return _get_simple_loader_fn_name_from_typename(typename)
	
	return load_with

func _get_save_with_prefix() -> String:
	var directive := _field_data.directive()
	var save_with := directive.save_with() if directive else ""
	
	if not save_with and is_field_simple():
		var typename := _field_data.field().type()
		return _get_simple_saver_fn_name_from_typename(typename)
	
	return save_with

func _get_simple_loader_fn_name_from_typename(typename: String) -> String:
	match typename:
		AS_TYPES.VECTOR_2: return "ASConversions.vector2_from_dict"
	push_warning("No simple loader configured for type '", typename, "'")
	return ""

func _get_simple_saver_fn_name_from_typename(typename: String) -> String:
	match typename:
		AS_TYPES.VECTOR_2: return "ASConversions.vector2_to_dict"
	push_warning("No simple saver configured for type '", typename, "'")
	return ""
