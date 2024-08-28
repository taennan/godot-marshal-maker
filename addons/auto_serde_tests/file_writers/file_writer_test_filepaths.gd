class_name _ASFileWriterTestFilepaths


var _root: String
var _is_loader: bool


static func for_loaders(root: String) -> _ASFileWriterTestFilepaths:
	return _ASFileWriterTestFilepaths.new(root, true)

static func for_savers(root: String) -> _ASFileWriterTestFilepaths:
	return _ASFileWriterTestFilepaths.new(root, false)

func _init(root: String, is_loader: bool):
	_root = root
	_is_loader = is_loader


func object() -> String:
	return ASPathLib.join(_root, "object.gd")


func expected() -> String:
	return _get_test_object_filepath(true)

func actual() -> String:
	return _get_test_object_filepath(false)

func _get_test_object_filepath(is_expected: bool) -> String:
	var test_type := "expected" if is_expected else "actual"
	var obj_type := "loader" if _is_loader else "saver"
	var suffix := "gd" if is_expected else "txt"
	
	var filename := "{0}_{1}.{2}".format([test_type, obj_type, suffix])
	return ASPathLib.join(_root, filename)
