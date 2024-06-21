class_name ASSerializerFileWriter

var _out_dir := "res://serializers"
var _conversion_config: Dictionary


func _init(out_dir: String, conversion_config: Dictionary):
	_out_dir = out_dir
	_conversion_config = conversion_config


func write() -> void:
	if not _can_write():
		return
	var filepath := _get_out_filepath()
	var file := FileAccess.open(filepath, FileAccess.WRITE)
	var text := _get_file_text()
	file.store_string(text)

func _can_write() -> bool:
	var object_name = _conversion_config["name"]
	return _out_dir and object_name

func _get_out_filepath() -> String:
	# TODO: Case convert
	var snakelized_class_name = _conversion_config["name"]
	return _out_dir + "/" + snakelized_class_name + ".gd"

func _get_file_text() -> String:
	return ""
