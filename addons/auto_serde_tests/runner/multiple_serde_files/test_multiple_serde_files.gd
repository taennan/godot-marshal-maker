extends GutTest


func test_writes_multiple_serde_file_loaders_and_savers():
	var srcdir := "res://addons/auto_serde_tests/runner/multiple_serde_files/objects/"
	var outdir := "res://addons/auto_serde_tests/runner/multiple_serde_files/actual/"
	var runner := ASWriterRunner.new(srcdir, outdir)
	
	runner.set_save_to_text_files(true)
	runner.go()
	
	_assert_files_equal("_as_runner_test_multiple_serde_files_child_object_loader.txt", "child_loader.gd")
	_assert_files_equal("_as_runner_test_multiple_serde_files_child_object_saver.txt", "child_saver.gd")
	_assert_files_equal("_as_runner_test_multiple_serde_files_parent_object_loader.txt", "parent_loader.gd")
	_assert_files_equal("_as_runner_test_multiple_serde_files_parent_object_saver.txt", "parent_saver.gd")

func _assert_files_equal(actual_filename: String, expected_filename: String) -> void:
	var actual_root_dir := "res://addons/auto_serde_tests/runner/multiple_serde_files/actual/"
	var expected_root_dir := "res://addons/auto_serde_tests/runner/multiple_serde_files/expected/"
	
	var actual_filepath := actual_root_dir + actual_filename
	var expected_filepath := expected_root_dir + expected_filename
	
	assert_true(FileAccess.file_exists(actual_filepath))
	assert_true(FileAccess.file_exists(expected_filepath))
	
	var actual_text := FileAccess.get_file_as_string(actual_filepath)
	var expected_text := FileAccess.get_file_as_string(expected_filepath)
	assert_eq(actual_text, expected_text)
