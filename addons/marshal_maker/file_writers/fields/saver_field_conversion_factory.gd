class_name MMSaverFieldConversionFactory
extends MMSerdeFieldConversionFactory


func _get_primitive_conversion() -> String:
	return "\tMMResult[\"{saved_name}\"] = {save_with_prefix}obj.{name}{save_with_suffix}\n"\
		.format(_formatting_data())

func _get_simple_conversion() -> String:
	return _get_primitive_conversion()

func _get_simple_array_conversion() -> String:
	return """
	MMResult[\"{saved_name}\"] = []
	for item in obj.{name}:
		var saved_item := {save_with_prefix}item{save_with_suffix}
		MMResult[\"{saved_name}\"].append(saved_item)
""".format(_formatting_data())

func _get_serde_conversion() -> String:
	return "\tMMResult[\"{saved_name}\"] = {save_with_prefix}{type}Saver.to_json(obj.{name}){save_with_suffix}\n"\
		.format(_formatting_data())

func _get_serde_array_conversion() -> String:
	return """
	MMResult[\"{saved_name}\"] = []
	for item in obj.{name}:
		var saved_item := {save_with_prefix}{type}Saver.to_json(item){save_with_suffix}
		MMResult[\"{saved_name}\"].append(saved_item)
""".format(_formatting_data())
