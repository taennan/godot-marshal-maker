class_name MMFieldTokens


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

func is_export() -> bool:
	return _get_clean_text().begins_with("@export")

func error() -> bool:
	return _error


func _update() -> void:
	if not _is_text_variable() or _is_text_computed_property_or_class_or_function():
		_error = true
		return
	
	_update_name()
	_update_type()


func _is_text_variable() -> bool:
	return is_export() or _get_clean_text().begins_with("var ")

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
		_type = MMStrLib.strip_edge_chars(item_type, MMStrLib.WHITESPACE_CHARS + "[]")
	elif _is_array and not item_type:
		_type = "Variant"
	else:
		_type = base_type

# TODO: We need to be able to infer many many more types
func _get_inferred_type() -> String:
	var text := _get_value_text()
	if _is_valid_int(text):
		return MM_TYPES.INT
	if text.is_valid_float():
		return MM_TYPES.FLOAT
	if _is_valid_string_type(text):
		return MM_TYPES.STRING
	
	var object_type := _get_object_type_from_constructor(text)
	if object_type:
		return object_type
	
	var simple_type := _get_simple_type_from_declaration(text)
	if simple_type:
		return simple_type
		
	push_error("Unknown type for value ", text)
	return MM_TYPES.VARIANT

func _get_value_text() -> String:
	var regex := RegEx.new()
	regex.compile(r"^(.*?)=\s*")
	var text := regex.sub(_get_clean_text(), "")
	return text

func _is_valid_int(text: String) -> bool:
	if "." in text:
		return false
	if (
		text.is_valid_int() 
		or text.is_valid_hex_number(true) 
		or _is_valid_binary(text)
	):
		return true
	
	var matches := MMStrLib.regex(r"\d(\d|_)*").search(text)
	var is_match := true if matches else false
	return is_match

func _is_valid_binary(text: String) -> bool:
	var regex := RegEx.new()
	regex.compile(r"^0b(0|1)+$")
	var matches := regex.search(text)
	return matches and matches.get_string() != ""

func _is_valid_string_type(text: String) -> bool:
	var regex := RegEx.new()
	regex.compile(r"""^r?('|")+.*('|")+""")
	return regex.search(text) != null

func _get_object_type_from_constructor(text: String) -> String:
	var matches := MMStrLib.regex(r"^(\w+)\.new\(").search(text.strip_edges())
	return matches.get_string(1) if matches else ""

func _get_simple_type_from_declaration(text: String) -> String:
	var matches := MMStrLib.regex(r"^(\w+)(\(|\.)").search(text.strip_edges())
	var matched_type := matches.get_string(1) if matches else ""
	return matched_type if matched_type in MM_TYPES.SIMPLE else ""
