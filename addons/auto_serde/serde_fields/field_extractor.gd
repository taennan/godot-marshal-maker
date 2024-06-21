class_name ASFieldExtractor


var _text: String


func _init(text: String):
	_text = text


func get_field_data() -> Array[ASFieldData]:
	var field_lines := _get_field_lines()
	var field_data: Array[ASFieldData] = []
	for line in field_lines:
		var name := _get_field_name(line)
		var type := _get_field_type(line)
		var data := ASFieldData.new(name, type)
		field_data.append(data)
	return field_data


# REFERENCE
# @export var var_name: TypeName
func _get_field_name(line: String) -> String:
	var trimmed := line.trim_prefix(" ").trim_suffix(" ").trim_suffix("\t")
	var splits := trimmed.split(" ", false, 3)
	var name_section := splits[2]
	var name_splits := name_section.split(":")
	
	

func _get_field_type(line: String) -> ASFieldData.Type:
	return ASFieldData.Type.VARIANT

func _get_field_lines() -> Array[String]:
	var lines := _text.split("\n")
	var field_lines: Array[String] = []
	for line in lines:
		if _is_field_line(line):
			field_lines.append(line)
	return field_lines

func _is_field_line(line: String) -> bool:
	return line.begins_with("@export")
