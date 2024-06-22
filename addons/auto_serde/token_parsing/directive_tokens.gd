class_name ASDirectiveTokens


var _text: String

var _targets_outer := false
var _all := false
var _ignore := false
var _default = null

var _error := false


func _init(text: String):
	_text = text
	_update()


func targets_outer() -> bool: return _targets_outer

func all() -> bool: return _all

func ignore() -> bool: return _ignore

func default(): return _default


func _update() -> void:
	if not _is_text_valid():
		_error = true
		return
	
	var keyvals := _get_keyvals()
	_targets_outer = _get_clean_text().begins_with("#![auto_serde")
	_all = _get_bool_param(keyvals, "all").unwrap_or(false)
	_ignore = _get_bool_param(keyvals, "ignore").unwrap_or(false)
	_default = keyvals.get("default")

func _is_text_valid() -> bool:
	var text := _get_clean_text()
	var is_auto_serde_directive := text.begins_with("#[auto_serde") or text.begins_with("#![auto_serde")
	var is_closed := text.rstrip(" \t").ends_with("]")
	return is_auto_serde_directive and is_closed

func _get_clean_text() -> String:
	var extra_space_regex := RegEx.new()
	extra_space_regex.compile(r"(\t|\s{2,})")
	var assignment_padding_regex := RegEx.new()
	assignment_padding_regex.compile(r"\s+=\s+")
	
	var result := extra_space_regex.sub(_text, " ", true)
	result = assignment_padding_regex.sub(result, "=", true)
	return result

func _get_keyvals() -> Dictionary:
	var result := {}
	var keyval_splits := _get_keyval_text().split(" ")
	
	for keyval_split in keyval_splits:
		var splits := keyval_split.split("=", false , 2)
		var key = ASArrLib.get_at(splits, 0)
		var value = ASArrLib.get_at(splits, 1, "true")
		
		result[key] = value
	
	return result

func _get_keyval_text() -> String:
	var directive_start_regex := RegEx.new()
	var directive_end_regex := RegEx.new()
	
	directive_start_regex.compile(r"^#\!?\[auto_serde\s*")
	directive_end_regex.compile(r"\s*\]\s*$")
	
	var text := _get_clean_text()
	var result := directive_start_regex.sub(text, "")
	result = directive_end_regex.sub(result, "")
	return result

func _get_bool_param(keyvals: Dictionary, key: String) -> Option:
	if not keyvals.has(key):
		return Option.none()
	
	var param = keyvals.get(key)
	match param:
		"true": return Option.some(true)
		"false": return Option.some(false)
		_:
			push_error("Unknown bool param ", param)
			return Option.none()
