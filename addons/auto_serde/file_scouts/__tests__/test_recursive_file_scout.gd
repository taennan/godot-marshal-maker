extends GutTest


const TEST_FILES_DIR := "res://addons/auto_serde/file_scouts/__tests__/recursive_file_scout_test_files"


func test_it_gets_filepaths_recursively():
	var expected := _filenames_to_fullpaths([
		"0.0",
		"0.1",
		"0.2/1.0",
		"0.2/1.1",
		"0.2/1.3/2.0"
	])
	var actual := _get_actual([])
	_run_assertions(actual, expected)

func test_it_ignores_specified_directories():
	var ignored := _dirnames_to_fullpaths(["0.2/1.3"])
	var expected := _filenames_to_fullpaths([
		"0.0",
		"0.1",
		"0.2/1.0",
		"0.2/1.1"
	])
	var actual := _get_actual(ignored)
	_run_assertions(actual, expected)

func test_it_ignores_specified_files():
	var ignored := _filenames_to_fullpaths(["0.1", "0.2/1.0", "0.2/1.3/2.0"])
	var expected := _filenames_to_fullpaths([
		"0.0",
		"0.2/1.1",
	])
	var actual := _get_actual(ignored)
	_run_assertions(actual, expected)


func _filenames_to_fullpaths(filenames: Array[String]) -> Array[String]:
	var fullpaths: Array[String] = []
	for filename in filenames:
		var filename_w_suffix := filename + ".txt"
		var fullpath := ASPathLib.join(TEST_FILES_DIR, filename_w_suffix)
		fullpaths.append(fullpath)
	return fullpaths

func _dirnames_to_fullpaths(dirnames: Array[String]) -> Array[String]:
	var fullpaths: Array[String] = []
	for dirname in dirnames:
		var fullpath := ASPathLib.join(TEST_FILES_DIR, dirname)
		fullpaths.append(fullpath)
	return fullpaths

func _get_actual(ignored_paths: Array[String]) -> Array[String]:
	return ASRecursiveFileScout.new(TEST_FILES_DIR, ignored_paths).get_filepaths()

func _run_assertions(actual: Array[String], expected: Array[String]) -> void:
	actual.sort()
	
	assert_eq(actual.size(), expected.size())
	for index in expected.size():
		var file := actual[index]
		assert_file_exists(file)
		assert_eq(file, expected[index])
