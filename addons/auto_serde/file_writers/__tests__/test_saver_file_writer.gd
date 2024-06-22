extends GutTest


class TEST_FILE_PATHS:
	const ROOT := "res://addons/auto_serde/file_writers/__tests__/saver_test_files/"
	const SAVED_OBJECT := ROOT + "saved_object.txt"
	const OTHER_OBJECT := ROOT + "other_object.txt"
	const OUTPUT := ROOT + "output.txt"
	const EXPECTED := ROOT + "expected.txt"


func test_it_writes_to_file_correctly():
	var saved_object_text := FileAccess.get_file_as_string(TEST_FILE_PATHS.SAVED_OBJECT)
	var saved_object_tokens := ASObjectTokens.new(saved_object_text)
	
	var other_object_text := FileAccess.get_file_as_string(TEST_FILE_PATHS.OTHER_OBJECT)
	var other_object_tokens := ASObjectTokens.new(other_object_text)
	
	var context := ASWriterContext.new()
	context.add_object_tokens(other_object_tokens)
	
	var writer := ASSaverFileWriter.new(TEST_FILE_PATHS.OUTPUT, saved_object_tokens, context)
	writer.write()
	
	var expected := FileAccess.get_file_as_string(TEST_FILE_PATHS.EXPECTED)
	var actual := FileAccess.get_file_as_string(TEST_FILE_PATHS.OUTPUT)
	assert_eq(actual, expected)
