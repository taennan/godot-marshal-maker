class_name FieldTokens


static func from_text(text: String) -> FieldTokens:
	var tokens := FieldTokens.new(text)
	tokens._update()
	return tokens


var _text: String

var comment: String
var decorator: String
var name: String
var type: String
var value: String

func _init(text: String):
	_text = text


func _update() -> void:
	_preprocess_text()
	_reset_properties()
	
	decorator = _search_for_tokens(r"^@(export|onready)\s+")
	name = _search_for_tokens("")
	type = _search_for_tokens("")
	value = _search_for_tokens("")

func _search_for_tokens(regex_pattern: String) -> String:
	var regex := RegEx.new()
	regex.compile(regex_pattern)
	var matches := regex.search(_text)
	return matches.get_string()

func _preprocess_text() -> void:
	_text = _text.replace("\t", " ").replace("   ", " ").replace("  ", " ")

func _reset_properties() -> void:
	decorator = ""
	name = ""
	type = ""
	value = ""

func _append_character_by_property_index(character: String, property_index: int) -> void:
	match property_index:
		0: decorator += character
		1: name += character
		2: type += character
		3: value += character
	
