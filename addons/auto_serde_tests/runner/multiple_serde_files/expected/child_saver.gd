# Autogenerated by AutoSerde (v0.0.0)
class_name _ASRunnerTestMultipleSerdeFilesChildObjectSaver


static func to_json_file(obj: _ASRunnerTestMultipleSerdeFilesChildObject, filepath: String) -> void:
	var text := _ASRunnerTestMultipleSerdeFilesChildObjectSaver.to_json_text(obj)
	FileAccess.open(filepath, FileAccess.WRITE).store_string(text)


static func to_json_text(obj: _ASRunnerTestMultipleSerdeFilesChildObject) -> String:
	var json := _ASRunnerTestMultipleSerdeFilesChildObjectSaver.to_json(obj)
	var text := JSON.stringify(json, "  ")
	return text


static func to_json(obj: _ASRunnerTestMultipleSerdeFilesChildObject) -> Dictionary:
	var result := {}
	result["grandchild"] = obj.grandchild
	return result
