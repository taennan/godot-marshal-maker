#![auto_serde]
class_name _ASFileWriterTestParentObject


@export var inferred_serde_obj := _ASFileWriterTestOtherObject.new()

@export var specified_serde_obj: _ASFileWriterTestOtherObject = null

@export var specified_serde_array: Array[_ASFileWriterTestOtherObject] = []
