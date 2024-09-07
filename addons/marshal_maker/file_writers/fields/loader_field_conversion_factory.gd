class_name MMLoaderFieldConversionFactory
extends MMSerdeFieldConversionFactory


func _get_primitive_conversion() -> String:
	return "\tobj.{name} = {load_with_prefix}json.get(\"{saved_name}\"){load_with_suffix}\n"\
		.format(_formatting_data())

func _get_simple_conversion() -> String:
	return _get_primitive_conversion()

func _get_simple_array_conversion() -> String:
	return """
	obj.{name} = []
	for item in json.get(\"{saved_name}\", []):
		var loaded_item := {load_with_prefix}item{load_with_suffix}
		obj.{name}.append(loaded_item)
""".format(_formatting_data())

func _get_serde_conversion() -> String:
	return "\tobj.{name} = {load_with_prefix}{type}Loader.from_json(json.get(\"{saved_name}\")){load_with_suffix}\n"\
		.format(_formatting_data())

func _get_serde_array_conversion() -> String:
	return """
	obj.{name} = []
	for item in json.get(\"{saved_name}\", []):
		var loaded_item := {load_with_prefix}{type}Loader.from_json(item){load_with_suffix}
		obj.{name}.append(loaded_item)
""".format(_formatting_data())
