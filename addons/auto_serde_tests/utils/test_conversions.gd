extends GutTest


class TestVector2Converters:
	extends GutTest
	
	func test_from_dict():
		var expected := Vector2(10, -2)
		var actual := ASConversions.vector2_from_dict({
			"x": 10.0,
			"y": -2.0,
		})
		assert_eq(actual, expected)
	
	func test_to_dict():
		var expected := {
			"x": 10.0,
			"y": -2.0,
		}
		var actual := ASConversions.vector2_to_dict(Vector2(10, -2))
		assert_eq(actual, expected)
	
	func test_from_array():
		var expected := Vector2(1, 3.14)
		var actual := ASConversions.vector2_from_array([1, 3.14])
		assert_eq(actual, expected)
	
	func test_to_array():
		var expected := [-6.28, 3.14]
		var actual := ASConversions.vector2_to_array(Vector2(-6.28, 3.14))
		assert_eq(actual.size(), expected.size())
		assert_almost_eq(actual[0], expected[0], 0.0001)
		assert_almost_eq(actual[1], expected[1], 0.0001)


class TestVector3Converters:
	extends GutTest
	
	func test_from_dict():
		var expected := Vector3(10, -2, 15.5)
		var actual := ASConversions.vector3_from_dict({
			"x": 10.0,
			"y": -2.0,
			"z": 15.5,
		})
		assert_eq(actual, expected)
	
	func test_to_dict():
		var expected := {
			"x": 10.0,
			"y": -2.0,
			"z": 15.5,
		}
		var actual := ASConversions.vector3_to_dict(Vector3(10, -2, 15.5))
		assert_eq(actual, expected)
	
	func test_from_array():
		var expected := Vector3(1, 3.14, -2.0)
		var actual := ASConversions.vector3_from_array([1, 3.14, -2.0])
		assert_eq(actual, expected)
	
	func test_to_array():
		var expected := [-6.28, 3.14, 101.0]
		var actual := ASConversions.vector3_to_array(Vector3(-6.28, 3.14, 101.0))
		assert_eq(actual.size(), expected.size())
		assert_almost_eq(actual[0], expected[0], 0.0001)
		assert_almost_eq(actual[1], expected[1], 0.0001)
		assert_almost_eq(actual[2], expected[2], 0.0001)
