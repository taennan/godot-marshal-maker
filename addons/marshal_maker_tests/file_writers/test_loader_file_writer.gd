extends GutTest


func test_it_writes_custom_conversions_correctly():
	_run_test("res://addons/marshal_maker_tests/file_writers/custom_conversion")

func test_it_writes_ignored_and_included_fields_correctly():
	_run_test("res://addons/marshal_maker_tests/file_writers/ignore_include")

func test_it_writes_primitive_fields_correctly():
	_run_test("res://addons/marshal_maker_tests/file_writers/primitives")

func test_it_writes_renamed_fields_correctly():
	_run_test("res://addons/marshal_maker_tests/file_writers/rename")

func test_it_writes_serde_object_fields_correctly():
	_run_test("res://addons/marshal_maker_tests/file_writers/serde_objects")


func _run_test(root_dir: String):
	var filepaths := _MMFileWriterTestFilepaths.for_loaders(root_dir)
	var context := MMFileWriterTestUtils.writer_context()
	var object_tokens := MMObjectTokens.from_file(filepaths.object())
	
	MMLoaderFileWriter.new(
		filepaths.actual(),
		object_tokens,
		context,
	).write()
	
	var actual := FileAccess.get_file_as_string(filepaths.actual())
	var expected := FileAccess.get_file_as_string(filepaths.expected())
	var is_equal := actual == expected
	assert_true(is_equal)
