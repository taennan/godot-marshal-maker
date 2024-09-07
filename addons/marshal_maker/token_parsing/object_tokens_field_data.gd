class_name MMObjectTokensFieldData


var _directive: MMDirectiveTokens
var _field: MMFieldTokens


func _init(directive: MMDirectiveTokens, field: MMFieldTokens):
	_directive = directive
	_field = field


func directive() -> MMDirectiveTokens:
	return _directive

func field() -> MMFieldTokens:
	return _field
