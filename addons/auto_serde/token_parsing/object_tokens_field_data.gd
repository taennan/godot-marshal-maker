class_name ASObjectTokensFieldData


var _directive: ASDirectiveTokens
var _field: ASFieldTokens


func _init(directive: ASDirectiveTokens, field: ASFieldTokens):
	_directive = directive
	_field = field


func directive() -> ASDirectiveTokens:
	return _directive

func field() -> ASFieldTokens:
	return _field
