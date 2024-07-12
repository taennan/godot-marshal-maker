extends GutTest


func test_it_writes_primitive_fields_correctly():
	var object_filepath := "res://addons/auto_serde_tests/file_writers/primitives/object.gd"
	var expected_filepath := "res://addons/auto_serde_tests/file_writers/primitives/expected_saver.gd"
	var actual_filepath := "res://addons/auto_serde_tests/file_writers/primitives/actual_saver.txt"
	_run_test(object_filepath, actual_filepath, expected_filepath)

func test_it_writes_renamed_fields_correctly():
	var object_filepath := "res://addons/auto_serde_tests/file_writers/rename/object.gd"
	var expected_filepath := "res://addons/auto_serde_tests/file_writers/rename/expected_saver.gd"
	var actual_filepath := "res://addons/auto_serde_tests/file_writers/rename/actual_saver.txt"
	_run_test(object_filepath, actual_filepath, expected_filepath)

func test_it_writes_ignored_and_included_fields_correctly():
	var object_filepath := "res://addons/auto_serde_tests/file_writers/ignore_include/object.gd"
	var expected_filepath := "res://addons/auto_serde_tests/file_writers/ignore_include/expected_saver.gd"
	var actual_filepath := "res://addons/auto_serde_tests/file_writers/ignore_include/actual_saver.txt"
	_run_test(object_filepath, actual_filepath, expected_filepath)

func test_it_writes_serde_object_fields_correctly():
	var object_filepath := "res://addons/auto_serde_tests/file_writers/serde_objects/object.gd"
	var expected_filepath := "res://addons/auto_serde_tests/file_writers/serde_objects/expected_saver.gd"
	var actual_filepath := "res://addons/auto_serde_tests/file_writers/serde_objects/actual_saver.txt"
	_run_test(object_filepath, actual_filepath, expected_filepath)


func _run_test(object_filepath: String, actual_filepath: String, expected_filepath: String):
	var context := ASFileWriterTestUtils.writer_context()
	var object_tokens := ASObjectTokens.from_file(object_filepath)
	
	ASSaverFileWriter.new(
		actual_filepath,
		object_tokens,
		context,
	).write()
	
	var actual := FileAccess.get_file_as_string(actual_filepath)
	var expected := FileAccess.get_file_as_string(expected_filepath)
	var is_equal := actual == expected
	assert_true(is_equal)
