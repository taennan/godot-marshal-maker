#![marshal_maker]
class_name _MMFileWriterTestCustomConversionObject


#[marshal_maker load_with=MMConversions.vector2_from_array save_with=MMConversions.vector2_to_array]
var position := Vector2(0, 0)

#[marshal_maker load_with=MMConversions.vector2_from_array]
var scale := Vector2.ONE
