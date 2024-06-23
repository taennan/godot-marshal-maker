extends GutTest


class _TEST_FILE_PATHS:
	const ROOT := ASFileWriterTestUtils.TEST_FILE_PATHS.ROOT + "loader/"
	const EXPECTED := ROOT + "expected.gd"
	const OUTPUT := ROOT + "output.txt"


func test_it_writes_to_file_correctly():
	var context := ASFileWriterTestUtils.writer_context()
	var saved_object_tokens := ASFileWriterTestUtils.saved_object_tokens()
	
	var writer := ASLoaderFileWriter.new(_TEST_FILE_PATHS.OUTPUT, saved_object_tokens, context)
	writer.write()
	
	var expected := FileAccess.get_file_as_string(_TEST_FILE_PATHS.EXPECTED)
	var actual := FileAccess.get_file_as_string(_TEST_FILE_PATHS.OUTPUT)
	var is_equal := actual == expected
	assert_true(is_equal)
	
	if is_equal:
		FileAccess.open(_TEST_FILE_PATHS.OUTPUT, FileAccess.WRITE).store_string("")

