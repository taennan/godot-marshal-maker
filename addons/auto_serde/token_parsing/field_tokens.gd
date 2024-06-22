class_name ASFieldTokens


var _text: String

var _name: String
var _type: String
var _is_array := false

var _error := false


func _init(text: String):
	_text = text
	_update()


func name() -> String:
	return _name

func type() -> String:
	return _type

func is_array() -> bool:
	return _is_array


func _update() -> void:
	if not _is_text_variable() or _is_text_computed_property_or_class_or_function():
		_error = true
		return
	
	_update_name()
	_update_type()


func _is_text_variable() -> bool:
	var text := _get_clean_text()
	return text.begins_with("@export") or text.begins_with("var ")

func _is_text_computed_property_or_class_or_function() -> bool:
	return _get_clean_text().ends_with(":")

func _get_clean_text() -> String:
	return _text.strip_edges()


func _update_name() -> void:
	var regex := RegEx.new()
	regex.compile(r"^(.*?)var\s+(\w+)")
	
	var matches := regex.search(_text)
	if not matches:
		_error = true
		return
	
	_name = matches.get_string(2)


func _update_type() -> void:
	_update_type_by_specified_type()
	if not _type and not _error:
		_type = _get_inferred_type()

func _update_type_by_specified_type() -> void:
	var regex := RegEx.new()
	regex.compile(r"^(.*?)var\s+\w+\s*:\s*(\w+(\[\s*\w+\s*])?)")
	
	var matches := regex.search(_text)
	if not matches:
		return
	
	var base_type := matches.get_string(2)
	var item_type := matches.get_string(3)
	
	_is_array = base_type == "Array" or base_type.begins_with("Array[")
	
	if _is_array and item_type:
		_type = ASStrLib.strip_edge_chars(item_type, ASStrLib.WHITESPACE_CHARS + "[]")
	elif _is_array and not item_type:
		_type = "Variant"
	else:
		_type = base_type

# TODO: We need to be able to infer many many more types
func _get_inferred_type() -> String:
	var text := _get_value_text()
	if text.is_valid_int() or text.is_valid_hex_number(true) or _is_valid_binary(text):
		return "int"
	if text.is_valid_float():
		return "float"
	if _is_valid_string_type(text):
		return "String"
		
	push_error("Unknown type for value ", text)
	return "Variant"

func _get_value_text() -> String:
	var regex := RegEx.new()
	regex.compile(r"^(.*?)=\s*")
	var text := regex.sub(_get_clean_text(), "")
	return text

func _is_valid_binary(text: String) -> bool:
	var regex := RegEx.new()
	regex.compile(r"^0b(0|1)+$")
	var matches := regex.search(text)
	return matches and matches.get_string() != ""

func _is_valid_string_type(text: String) -> bool:
	var regex := RegEx.new()
	regex.compile(r"""^r?('|")+.*('|")+""")
	return regex.search(text) != null
