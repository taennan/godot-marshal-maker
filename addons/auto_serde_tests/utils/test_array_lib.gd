extends GutTest


class TestGetAt:
	extends GutTest
	
	func test_it_gets_item_at_index_if_found():
		var array := ["A", "B", "C", "D"]
		var index := 3
		assert_eq(ASArrLib.get_at(array, index), "D")
	
	func test_it_returns_default_if_no_item_at_index():
		var array := []
		var default := 43
		assert_eq(ASArrLib.get_at(array, 2, default), default)
