# Autogenerated by MarshalMaker (v0.0.0)
class_name _MMRunnerTestMultipleSerdeFilesChildObjectSaver


static func to_json_file(obj: _MMRunnerTestMultipleSerdeFilesChildObject, filepath: String) -> void:
	var text := _MMRunnerTestMultipleSerdeFilesChildObjectSaver.to_json_text(obj)
	FileAccess.open(filepath, FileAccess.WRITE).store_string(text)


static func to_json_text(obj: _MMRunnerTestMultipleSerdeFilesChildObject) -> String:
	var json := _MMRunnerTestMultipleSerdeFilesChildObjectSaver.to_json(obj)
	var text := JSON.stringify(json, "  ")
	return text


static func to_json(obj: _MMRunnerTestMultipleSerdeFilesChildObject) -> Dictionary:
	var MMResult := {}
	MMResult["grandchild"] = obj.grandchild
	return MMResult
