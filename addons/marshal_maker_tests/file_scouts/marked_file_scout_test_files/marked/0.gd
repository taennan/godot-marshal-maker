#![marshal_maker]
class_name MMTestFileBasic0
extends RefCounted


@export var a := 0

@export var b := "1"

@export var c: Array[float] = [2.0, 3.0]

var d = "Variant"

const CONSTANT: String = "Constant"


func _test_function():
	pass

func _test_function_with_param(_param) -> void:
	pass


class _TestInternalClass:
	pass
