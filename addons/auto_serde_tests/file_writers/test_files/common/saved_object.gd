#![auto_serde]
class_name _ASFileWriterTestSavedObject


@export var inferred_string := r"Apple"

@export_range(0.0, 1.0) var inferred_float := 3.14

@export var inferred_int := 10_000

@export var inferred_binary := 0b001

@export var inferred_hex := 0x0232aF

@export var specified_string: String = """triple-string-thing"""

@export var specified_float: float = 6.28

@export var specified_int: int = 123

#[auto_serde ignore]
@export var ignored_export_var: int = 0

var ignored_var := 10

#[auto_serde]
var included_var := '3BusyBees'

@export var inferred_serde_obj := _ASFileWriterTestOtherObject.new()

@export var specified_serde_obj: _ASFileWriterTestOtherObject = null

@export var specified_serde_array: Array[_ASFileWriterTestOtherObject] = []


class _IgnoredInternalClass:

	@export var field_a := "ignore-me!"
