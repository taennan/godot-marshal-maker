#![auto_serde]
class_name _ASDirectiveTokensTest_Basic


@export var a := "A"

#[auto_serde]
var b := 2

@export_range(0.0, 10.0) var c := 4.34


func _test() -> void:
	pass
