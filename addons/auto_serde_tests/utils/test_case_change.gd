extends GutTest


class _INPUT:
	const CAMEL := "camelCase"
	const PASCAL := "PascalCase"
	const SENTANCE := "Sentance case"
	const TITLE  := "Title Case"
	const SNAKE := "snake_case"
	const UPPER_SNAKE := "UPPER_SNAKE_CASE"
	const KEBAB := "kebab-case"
	const UPPER_KEBAB := "UPPER-KEBAB-CASE"


func _test_case_fn(fn: Callable, input: String, expected: String) -> void:
	var actual: String = fn.callv([input])
	assert_eq(actual, expected)


func test_kebab_case():
	var tested_fn := ASCaseChange.kebab
	_test_case_fn(tested_fn, _INPUT.CAMEL, "camel-case")
	_test_case_fn(tested_fn, _INPUT.PASCAL, "pascal-case")
	_test_case_fn(tested_fn, _INPUT.SENTANCE, "sentance-case")
	_test_case_fn(tested_fn, _INPUT.TITLE, "title-case")
	_test_case_fn(tested_fn, _INPUT.SNAKE, "snake-case")
	_test_case_fn(tested_fn, _INPUT.UPPER_SNAKE, "upper-snake-case")
	_test_case_fn(tested_fn, _INPUT.KEBAB, "kebab-case")
	_test_case_fn(tested_fn, _INPUT.UPPER_KEBAB, "upper-kebab-case")

func test_sentance_case():
	var tested_fn := ASCaseChange.sentance
	_test_case_fn(tested_fn, _INPUT.CAMEL, "Camel case")
	_test_case_fn(tested_fn, _INPUT.PASCAL, "Pascal case")
	_test_case_fn(tested_fn, _INPUT.SENTANCE, "Sentance case")
	_test_case_fn(tested_fn, _INPUT.TITLE, "Title case")
	_test_case_fn(tested_fn, _INPUT.SNAKE, "Snake case")
	_test_case_fn(tested_fn, _INPUT.UPPER_SNAKE, "Upper snake case")
	_test_case_fn(tested_fn, _INPUT.KEBAB, "Kebab case")
	_test_case_fn(tested_fn, _INPUT.UPPER_KEBAB, "Upper kebab case")

func test_title_case():
	var tested_fn := ASCaseChange.title
	_test_case_fn(tested_fn, _INPUT.CAMEL, "Camel Case")
	_test_case_fn(tested_fn, _INPUT.PASCAL, "Pascal Case")
	_test_case_fn(tested_fn, _INPUT.SENTANCE, "Sentance Case")
	_test_case_fn(tested_fn, _INPUT.TITLE, "Title Case")
	_test_case_fn(tested_fn, _INPUT.SNAKE, "Snake Case")
	_test_case_fn(tested_fn, _INPUT.UPPER_SNAKE, "Upper Snake Case")
	_test_case_fn(tested_fn, _INPUT.KEBAB, "Kebab Case")
	_test_case_fn(tested_fn, _INPUT.UPPER_KEBAB, "Upper Kebab Case")
