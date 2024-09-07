class_name MMFileWriterTestUtils


static func writer_context() -> MMWriterContext:
	var filepath := "res://addons/marshal_maker_tests/file_writers/utils/other_object.gd"
	var other_object_tokens := MMObjectTokens.from_file(filepath)
	
	var context := MMWriterContext.new()
	context.add_object_tokens(other_object_tokens)
	
	return context
