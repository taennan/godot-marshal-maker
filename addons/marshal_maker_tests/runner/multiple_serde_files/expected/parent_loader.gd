# Autogenerated by MarshalMaker (v0.0.0)
class_name _MMRunnerTestMultipleSerdeFilesParentObjectLoader


static func from_json_file(filepath: String) -> _MMRunnerTestMultipleSerdeFilesParentObject:
	var text := FileAccess.get_file_as_string(filepath)
	var obj := _MMRunnerTestMultipleSerdeFilesParentObjectLoader.from_json_text(text)
	return obj


static func from_json_text(text: String) -> _MMRunnerTestMultipleSerdeFilesParentObject:
	var json := JSON.parse_string(text)
	var obj := _MMRunnerTestMultipleSerdeFilesParentObjectLoader.from_json(json)
	return obj


static func from_json(json: Dictionary) -> _MMRunnerTestMultipleSerdeFilesParentObject:
	var obj := _MMRunnerTestMultipleSerdeFilesParentObject.new()
	obj.child = _MMRunnerTestMultipleSerdeFilesChildObjectLoader.from_json(json.get("child"))
	return obj
