## Abstract class
class_name ASSerdeFileWriter


var _filepath: String
var _obj_tokens: ASObjectTokens
var _context: ASWriterContext

class _TemplateValues:
	var type := ""
	var auto_serde_version := ""
	var primitive_conversions := ""
	var serde_conversions := ""
	var serde_array_conversions := ""
	
	func to_json() -> Dictionary:
		return {
			"type": type,
			"auto_serde_version": auto_serde_version,
			"primitive_conversions": primitive_conversions,
			"serde_conversions": serde_conversions,
			"serde_array_conversions": serde_array_conversions,
		}


func _init(filepath: String, obj_tokens: ASObjectTokens, context: ASWriterContext):
	_filepath = filepath
	_obj_tokens = obj_tokens
	_context = context


func write() -> void:
	FileAccess.open(_filepath, FileAccess.WRITE).store_string(_get_text())


func _get_text() -> String:
	var template := _get_template()
	var template_values := _get_template_values().to_json()
	var filled_template := template.format(template_values)
	var text := _adjust_empty_lines_from_filled_template(filled_template)
	return text


func _get_template() -> String:
	push_error("ASSerdeFileWriter._get_template is meant to be overridden")
	return ""


func _get_template_values() -> _TemplateValues:
	var values := _TemplateValues.new()
	values.type = _obj_tokens.type()
	values.auto_serde_version = _context.auto_serde_version()
	
	for field_data in _obj_tokens.fields():
		var factory := _get_field_conversion_factory(field_data)
		var conversion_string := factory.make()
		
		if factory.is_field_primitive():
			values.primitive_conversions += conversion_string
		elif factory.is_field_serde_object():
			values.serde_conversions += conversion_string
		elif factory.is_field_serde_array():
			values.serde_array_conversions += conversion_string
	
	return values

func _get_field_conversion_factory(_field_data: ASObjectTokensFieldData) -> ASSerdeFieldConversionFactory:
	push_error("ASSerdeFileWriter._get_field_conversion_factory is meant to be overridden")
	return null


func _adjust_empty_lines_from_filled_template(text: String) -> String:
	var empty_tabless_text := ASStrLib.regex(r"^\s*$").sub(text, "", true)
	var empty_lineless_text := ASStrLib.regex(r"\n{2,}").sub(empty_tabless_text, "\n", true)
	var spaced_functions_text := empty_lineless_text.replace("\nstatic func ", "\n\n\nstatic func ")
	var empty_line_at_end_text := spaced_functions_text + "\n"
	return empty_line_at_end_text
