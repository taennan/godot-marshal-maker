extends GutTest


class TEST_FILES:
	const ROOT     := "res://addons/marshal_maker_tests/file_scouts/marked_file_scout_test_files/"
	const MARKED   := ROOT + "marked"
	const UNMARKED := ROOT + "unmarked"
	const INVALID  := ROOT + "invalid"


func test_it_returns_recursive_files_marked_with_valid_directive():
	var actual := MMMarkedFileScout.new(TEST_FILES.ROOT).get_filepaths()
	actual.sort()
	
	var expected := [
		MMPathLib.join(TEST_FILES.MARKED, "0.gd"),
		MMPathLib.join(TEST_FILES.MARKED, "1.gd"),
	]
	
	assert_eq(actual, expected)
