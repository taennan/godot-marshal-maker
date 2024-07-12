class_name ASFileWriterTestUtils


static func writer_context() -> ASWriterContext:
	var filepath := "res://addons/auto_serde_tests/file_writers/utils/other_object.gd"
	var other_object_tokens := ASObjectTokens.from_file(filepath)
	
	var context := ASWriterContext.new()
	context.add_object_tokens(other_object_tokens)
	
	return context
