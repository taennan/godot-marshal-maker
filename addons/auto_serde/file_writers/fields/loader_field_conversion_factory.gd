class_name ASLoaderFieldConversionFactory
extends ASSerdeFieldConversionFactory


func _get_primitive_conversion() -> String:
	return "\tobj.{name} = json.get(\"{name}\")\n".format(_formatting_data())

func _get_serde_conversion() -> String:
	return "\tobj.{name} = {type}Loader.from_json(json.get(\"{name}\"))\n".format(_formatting_data())

func _get_serde_array_conversion() -> String:
	return """
	obj.{name} = []
	for item in json.get(\"{name}\", []):
		var loaded_item := {type}Loader.from_json(item)
		obj.{name}.append(loaded_item)
""".format(_formatting_data())
