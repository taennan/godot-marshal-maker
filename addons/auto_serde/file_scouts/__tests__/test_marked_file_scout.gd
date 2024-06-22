extends GutTest


class TEST_FILES:
	const ROOT     := "res://addons/auto_serde/file_scouts/__tests__/marked_file_scout_test_files/"
	const MARKED   := ROOT + "marked"
	const UNMARKED := ROOT + "unmarked"
	const INVALID  := ROOT + "invalid"


func test_it_returns_recursive_files_marked_with_valid_directive():
	var actual := ASMarkedFileScout.new(TEST_FILES.ROOT).get_filepaths()
	actual.sort()
	
	var expected := [
		ASPathLib.join(TEST_FILES.MARKED, "0.gd"),
		ASPathLib.join(TEST_FILES.MARKED, "1.gd"),
	]
	
	assert_eq(actual, expected)
