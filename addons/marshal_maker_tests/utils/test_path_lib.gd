extends GutTest


class TestParent:
	extends GutTest
	
	func test_it_returns_parent_segments_when_found():
		var input := "a/b/c/d.txt"
		var actual := MMPathLib.parent(input)
		var expected := "a/b/c"
		assert_eq(actual, expected)
	
	func test_it_returns_input_if_no_parent_is_found():
		var expected := "random_file.gd"
		var actual := MMPathLib.parent(expected)
		assert_eq(actual, expected)
