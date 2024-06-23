class_name ASFileWriterTestUtils


class TEST_FILE_PATHS:
	const ROOT := "res://addons/auto_serde_tests/file_writers/test_files/"
	const _COMMON := ROOT + "common/"


static func writer_context() -> ASWriterContext:
	var path := TEST_FILE_PATHS._COMMON + "other_object.gd"
	var other_object_text := FileAccess.get_file_as_string(path)
	var other_object_tokens := ASObjectTokens.new(other_object_text)
	
	var context := ASWriterContext.new()
	context.add_object_tokens(other_object_tokens)
	
	return context


static func saved_object_tokens() -> ASObjectTokens:
	var path := TEST_FILE_PATHS._COMMON + "saved_object.gd"
	var text := FileAccess.get_file_as_string(path)
	var tokens := ASObjectTokens.new(text)
	return tokens
