class_name ASSaverFieldConversionFactory
extends ASSerdeFieldConversionFactory


func _get_primitive_conversion() -> String:
	return "\tresult[\"{name}\"] = obj.{name}\n".format(_formatting_data())

func _get_serde_conversion() -> String:
	return "\tresult[\"{name}\"] = {type}Saver.to_json(obj.{name})\n".format(_formatting_data())

func _get_serde_array_conversion() -> String:
	return """
	result[\"{name}\"] = []
	for item in obj.{name}:
		var saved_item := {type}Saver.to_json(item)
		result[\"{name}\"].append(saved_item)
""".format(_formatting_data())
