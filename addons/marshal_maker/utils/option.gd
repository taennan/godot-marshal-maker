class_name MMOption


static func some(value) -> MMOption:
	return MMOption.new(value, true)

static func none() -> MMOption:
	return MMOption.new(null, false)


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
