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
	if is_field_serde_array():  return _get_serde_array_conversion()
	if is_field_serde_object(): return _get_serde_conversion()
	
	push_error(
		"Couldn't decide how to convert field ", 
		_field_data.field().name(),
		" ",
		_field_data.field().type(),
	)
	return ""


func _is_field_ignored() -> bool:
	var has_directive := _field_data.directive() != null
	var has_ignore_directive := has_directive and _field_data.directive().ignore()
	var is_directiveless_normal_var := not has_directive and not _field_data.field().is_export()
	
	return has_ignore_directive or is_directiveless_normal_var


func is_field_primitive() -> bool:
	return _field_data.field().type() in AS_TYPES.PRIMITIVE

func is_field_serde_array() -> bool:
	return _field_data.field().is_array() and is_field_serde_object()

func is_field_serde_object() -> bool:
	return _context.has_object_of_type(_field_data.field().type())


func _get_primitive_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_primitive_conversion method is meant to be overridden")
	return ""

func _get_serde_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory.__get_serde_conversion method is meant to be overridden")
	return ""

func _get_serde_array_conversion() -> String:
	push_error("ASSerdeFieldConversionFactory._get_serde_array_conversion method is meant to be overridden")
	return ""


func _formatting_data() -> Dictionary:
	return {
		"name": _field_data.field().name(),
		"type": _field_data.field().type(),
	}
