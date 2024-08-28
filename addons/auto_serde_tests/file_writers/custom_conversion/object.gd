#![auto_serde]
class_name _ASFileWriterTestCustomConversionObject


#[auto_serde load_with=ASConversions.vector2_from_array save_with=ASConversions.vector2_to_array]
var position := Vector2(0, 0)

#[auto_serde load_with=ASConversions.vector2_from_array]
var scale := Vector2.ONE
