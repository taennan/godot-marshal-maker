class_name Option


static func some(value) -> Option:
	return Option.new(value, true)

static func none() -> Option:
	return Option.new(null, false)


var _value = null
var _some := false

var value:
	get: return _value

var is_some: bool:
	get: return _some

var is_none: bool:
	get: return not is_some


func _init(val, some: bool):
	_value = val
	_some = some


func unwrap_or(default_value):
	return default_value if is_none else value
