extends GutTest


class TestNameParsing:
	extends GutTest
	
	func test_it_parses_name_from_var():
		var tokens := ASFieldTokens.new("var field_name: int = 32")
		var expected := "field_name"
		assert_false(tokens.error())
		assert_eq(tokens.name(), expected)
	
	func test_it_parses_name_from_export_var():
		var tokens := ASFieldTokens.new("@export var pi := 3.14")
		var expected := "pi"
		assert_false(tokens.error())
		assert_eq(tokens.name(), expected)


class TestTypeParsing:
	extends GutTest
	
	func test_it_parses_primitive_type_when_specified():
		var tokens := ASFieldTokens.new("@export_range() var tau: float = 6.28 ")
		var expected := "float"
		assert_false(tokens.error())
		assert_eq(tokens.type(), expected)
	
	func test_it_parses_object_type_when_specified():
		var tokens := ASFieldTokens.new("var car:Car= Car.new()")
		var expected := "Car"
		assert_false(tokens.error())
		assert_eq(tokens.type(), expected)
	
	func test_it_parses_variant_array_type_when_specified():
		var tokens := ASFieldTokens.new("var car: Array = []")
		assert_false(tokens.error())
		assert_true(tokens.is_array())
		assert_eq(tokens.type(), "Variant")
	
	func test_it_parses_array_type_with_item_type_when_specified():
		var tokens := ASFieldTokens.new("var colors: Array[ Color] = []")
		assert_false(tokens.error())
		assert_true(tokens.is_array())
		assert_eq(tokens.type(), "Color")
	
	func test_it_infers_single_types():
		var assignment_ops := ["=", ":="]
		var test_data: Array[InferredTypeTestData] = [
			InferredTypeTestData.new("int", "0b01010"),
			InferredTypeTestData.new("int", "0xa3A9D01"),
			InferredTypeTestData.new("int", "2323"),
			InferredTypeTestData.new("float", "3.14"),
			InferredTypeTestData.new("String", r'"Hello, world!"'),
			InferredTypeTestData.new("String", r"'Auto Serde!'"),
		]
		
		for op in assignment_ops:
			for data in test_data:
				var text := "var field_name {0} {1}".format([op, data.value])
				var tokens := ASFieldTokens.new(text)
				assert_false(tokens.error())
				assert_eq(tokens.type(), data.type)
	
	class InferredTypeTestData:
		var type: String
		var value: String
		
		func _init(t: String, v: String):
			type = t
			value = v
