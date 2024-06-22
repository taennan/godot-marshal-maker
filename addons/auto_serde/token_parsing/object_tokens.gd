class_name ASObjectTokens


var _text: String

var _type: String
var _directive: ASDirectiveTokens
var _fields: Array[ASObjectTokensFieldData]

var _error := false


func _init(text: String):
	_text = text
	_update()


func type() -> String: return _type

func directive() -> ASDirectiveTokens: return _directive

func fields() -> Array[ASObjectTokensFieldData]: return _fields

func error() -> bool: return _error


func _update() -> void:
	_update_directive()
	_update_fields()


func _update_directive() -> void:
	var line := _get_object_directive_line()
	var tokens := ASDirectiveTokens.new(line)
	if tokens.error:
		_error = true
		return
	_directive = tokens

func _get_object_directive_line() -> String:
	var line := ASFileLineIterator.new(_text).find_line(_is_line_object_directive)
	return line.unwrap_or("")

func _is_line_object_directive(line: String) -> bool:
	var tokens := ASDirectiveTokens.new(line)
	return not tokens.error and tokens.targets_outer


func _update_fields() -> void:
	var lines := _get_clean_text().split("\n")
	lines.reverse()
	
	var field_data: Array[ASObjectTokensFieldData] = []
	for line in lines:
	
		if _is_line_field(line):
			var field_tokens := ASFieldTokens.new(line)
			var new_data := ASObjectTokensFieldData.new(null, field_tokens)
			field_data.append(new_data)
		
		elif _is_line_field_directive(line):
			var old_data: ASObjectTokensFieldData = ASArrLib.back(field_data)
			if old_data and not old_data.directive:
				var field_directive := ASDirectiveTokens.new(line)
				var new_data := ASObjectTokensFieldData.new(field_directive, old_data.field())
				ASArrLib.set_at(field_data, field_data.size() - 1, new_data)
	
	_fields = field_data

func _get_clean_text() -> String:
	var text := ASFileLineIterator.new(_text).filter_lines(_is_line_pertaining_to_fields)
	return text

func _is_line_pertaining_to_fields(line: String) -> bool:
	return _is_line_field_directive(line) or _is_line_field(line)

func _is_line_field_directive(line: String) -> bool:
	var directive := ASDirectiveTokens.new(line.strip_edges())
	return not directive.error and not directive.targets_outer

func _is_line_field(line: String) -> bool:
	var text := line.strip_edges()
	var is_export_var := text.begins_with("@export")
	var is_var := text.begins_with("var ")
	return is_var or is_export_var
