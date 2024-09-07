class_name MMObjectTokens


var _text: String

var _type: String
var _directive: MMDirectiveTokens
var _fields: Array[MMObjectTokensFieldData]

var _error := false


static func from_file(filepath: String) -> MMObjectTokens:
	var text := FileAccess.get_file_as_string(filepath)
	var tokens := MMObjectTokens.new(text)
	return tokens

func _init(text: String):
	_text = text
	_update()


func type() -> String: 
	return _type

func directive() -> MMDirectiveTokens: 
	return _directive

func fields() -> Array[MMObjectTokensFieldData]: 
	return _fields

func error() -> bool: 
	return _error


func _update() -> void:
	_update_type()
	_update_directive()
	_update_fields()


func _update_type() -> void:
	for line in _text.split("\n"):
		var type_name = _get_type_name_from_line(line)
		if type_name:
			_type = type_name
			return
	_error = true

func _get_type_name_from_line(line: String) -> String:
	var regex := RegEx.new()
	regex.compile(r"^class_name\s+(\w+)")
	var matches := regex.search(line.strip_edges())
	var type_name := matches.get_string(1) if matches else ""
	return type_name


func _update_directive() -> void:
	var line := _get_object_directive_line()
	var tokens := MMDirectiveTokens.new(line)
	if tokens.error():
		_error = true
		return
	_directive = tokens

func _get_object_directive_line() -> String:
	var lines := _text.split("\n")
	for line in lines:
		if _is_line_object_directive(line):
			return line
	return ""

func _is_line_object_directive(line: String) -> bool:
	var tokens := MMDirectiveTokens.new(line)
	return not tokens.error() and tokens.targets_outer()


func _update_fields() -> void:
	var lines := _get_clean_text().split("\n")
	lines.reverse()
	
	var field_data: Array[MMObjectTokensFieldData] = []
	for line in lines:
	
		if _is_line_field(line):
			var field_tokens := MMFieldTokens.new(line)
			var new_data := MMObjectTokensFieldData.new(null, field_tokens)
			field_data.append(new_data)
		
		elif _is_line_field_directive(line):
			var old_data: MMObjectTokensFieldData = MMArrLib.back(field_data)
			if old_data and not old_data.directive():
				var field_directive := MMDirectiveTokens.new(line)
				var new_data := MMObjectTokensFieldData.new(field_directive, old_data.field())
				MMArrLib.set_at(field_data, field_data.size() - 1, new_data)
	
	field_data.reverse()
	_fields = field_data

func _get_clean_text() -> String:
	var text := ""
	for line in _text.split("\n", false):
		if _is_line_pertaining_to_fields(line):
			text += line + "\n"
	return text

func _is_line_pertaining_to_fields(line: String) -> bool:
	return _is_line_field_directive(line) or _is_line_field(line)

func _is_line_field_directive(line: String) -> bool:
	var directive := MMDirectiveTokens.new(line.strip_edges())
	return not directive.error() and not directive.targets_outer()

func _is_line_field(line: String) -> bool:
	var is_export_var := line.begins_with("@export")
	var is_var := line.begins_with("var ")
	return is_var or is_export_var
