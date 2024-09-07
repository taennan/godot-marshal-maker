#![marshal_maker]
class_name _MMFileWriterTestParentObject


@export var inferred_serde_obj := _MMFileWriterTestOtherObject.new()

@export var specified_serde_obj: _MMFileWriterTestOtherObject = null

@export var specified_serde_array: Array[_MMFileWriterTestOtherObject] = []
