extends GutTest


class TEST_FILE_PATHS:
	const ROOT := "res://addons/marshal_maker_tests/token_parsing/directive_tokens_test_files/"
	const VALID := ROOT + "valid.gd"
	const NO_DIRECTIVE := ROOT + "no_directive.gd"
	const NO_CLASS_NAME := ROOT + "no_class_name.gd"


func test_it_parses_valid_files_correctly():
	var text := FileAccess.get_file_as_string(TEST_FILE_PATHS.VALID)
	var object_tokens := MMObjectTokens.new(text)
	
	var field_names := object_tokens.fields().map(func(data): return data.field().name())
	var field_types := object_tokens.fields().map(func(data): return data.field().type())
	field_names.sort()
	field_types.sort()
	
	assert_eq(object_tokens.fields().size(), 3)
	assert_eq(field_names, ["a", "b", "c"])
	assert_eq(field_types, [MM_TYPES.STRING, MM_TYPES.FLOAT, MM_TYPES.INT])

func test_it_errors_on_files_without_directive():
	var text := FileAccess.get_file_as_string(TEST_FILE_PATHS.NO_DIRECTIVE)
	var object_tokens := MMObjectTokens.new(text)
	assert_true(object_tokens.error())

func test_it_errors_on_files_without_class_name():
	var text := FileAccess.get_file_as_string(TEST_FILE_PATHS.NO_CLASS_NAME)
	var object_tokens := MMObjectTokens.new(text)
	assert_true(object_tokens.error())
