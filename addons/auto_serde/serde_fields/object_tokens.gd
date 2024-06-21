class_name ObjectTokens


var _text: String

var _comment: String
var _type: String
var _fields: Array[FieldTokens]

var _error := false


static func from_text(text: String) -> ObjectTokens:
	var tokens := ObjectTokens.new()
	tokens._text = text
	tokens._update()
	return tokens


func _update() -> void:
	pass


func _get_field_and_directive_lines() -> Array[String]:
	var lines: Array[String] = []
	for line in _text.split("\n"):
		if _is_field_or_directive_line(line):
			lines.append(line)
	return lines

func _is_field_or_directive_line(line: String) -> bool:
	return (
		line.begins_with("#[auto_serde ")
		or line.begins_with("var ")
		or line.begins_with("@export")
	)

