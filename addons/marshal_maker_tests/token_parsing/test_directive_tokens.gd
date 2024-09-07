extends GutTest

class TestValidDirectives:
	extends GutTest
	
	func test_it_does_not_error_on_base_directive():
		var line := "#[marshal_maker]"
		var tokens := MMDirectiveTokens.new(line)
		assert_false(tokens.error())
	
	func test_it_does_not_error_on_outer_directive():
		var line := "#![marshal_maker]"
		var tokens := MMDirectiveTokens.new(line)
		assert_false(tokens.error())
	
	func test_it_does_not_error_on_base_directive_with_space_at_the_end():
		var line := "#[marshal_maker  ]"
		var tokens := MMDirectiveTokens.new(line)
		assert_false(tokens.error())
	
	func test_it_errors_on_invalid_directive():
		var invalids := [
			"##[marshal_maker]",
			"#![ marshal_maker]",
			"#[	marshal_maker]",
			"#(marshal_maker)"
		]
		for invalid in invalids:
			var tokens := MMDirectiveTokens.new(invalid)
			assert_true(tokens.error())

class TestParams:
	extends GutTest
	
	func test_it_gets_params():
		var line := "#[marshal_maker ignore=false all default=3]"
		var tokens := MMDirectiveTokens.new(line)
		assert_false(tokens.ignore())
		assert_true(tokens.all())
		assert_eq(tokens.default(), "3")
