#![marshal_maker]
class_name _MMDirectiveTokensTest_Basic


@export var a := "A"

#[marshal_maker]
var b := 2

@export_range(0.0, 10.0) var c := 4.34


func _test() -> void:
	pass
