class_name MMLoaderFileWriter
extends MMMarshallerFileWriter


func _get_template() -> String:
	return r"""
# Autogenerated by MarshalMaker ({marshal_maker_version})
class_name {type}Loader

static func from_json_file(filepath: String) -> {type}:
	var text := FileAccess.get_file_as_string(filepath)
	var obj := {type}Loader.from_json_text(text)
	return obj

static func from_json_text(text: String) -> {type}:
	var json := JSON.parse_string(text)
	var obj := {type}Loader.from_json(json)
	return obj

static func from_json(json: Dictionary) -> {type}:
	var obj := {type}.new()
{primitive_conversions}
{simple_conversions}
{simple_array_conversions}
{serde_conversions}
{serde_array_conversions}
	return obj
""".strip_edges()

func _get_field_conversion_factory(field_data: MMObjectTokensFieldData) -> MMSerdeFieldConversionFactory:
	return MMLoaderFieldConversionFactory.new(field_data, _context)
