class_name ASWriterRunner


signal created_temp_outdir
signal marked_file_found(filepath: String)
signal saver_written(typename: String)
signal loader_written(typename: String)
signal deleted_temp_outdir


var _srcdir: String
var _outdir: String
var _temp_outdir := ""

var _save_to_text_files := false


func _init(srcdir: String, outdir: String):
	_srcdir = srcdir
	_outdir = outdir


func set_save_to_text_files(new_value: bool) -> void:
	_save_to_text_files = new_value


func go() -> void:
	_rename_old_outdir()
	_write_new_outdir()
	_delete_temp_outdir()


func _rename_old_outdir() -> void:
	if not DirAccess.dir_exists_absolute(_outdir):
		return
	
	var parent := ASPathLib.parent(_outdir)
	var dirname := ASPathLib.name(_outdir)
	
	var temp_name := ASUniqueFilenameFactory.new(parent).unique_name_ending_with(dirname)
	_temp_outdir = ASPathLib.join(parent, temp_name)
	
	DirAccess.rename_absolute(_outdir, _temp_outdir)
	created_temp_outdir.emit()

func _delete_temp_outdir() -> void:
	OS.move_to_trash(_temp_outdir)
	_temp_outdir = ""
	deleted_temp_outdir.emit()


func _write_new_outdir() -> void:
	DirAccess.make_dir_absolute(_outdir)
	
	var writer_context := _get_writer_context()
	_write_savers(writer_context)
	_write_loaders(writer_context)

func _get_writer_context() -> ASWriterContext:
	var context := ASWriterContext.new()
	var marked_files := ASMarkedFileScout.new(_srcdir).get_filepaths()
	
	for file in marked_files:
		var object_tokens := ASObjectTokens.from_file(file)
		if not object_tokens.error():
			context.add_object_tokens(object_tokens)
			marked_file_found.emit(file)
	
	return context

func _write_savers(context: ASWriterContext) -> void:
	for object_tokens in context.object_tokens():
		var filepath := _file_save_path(object_tokens, false)
		var writer := ASSaverFileWriter.new(filepath, object_tokens, context)
		writer.write()
		
		saver_written.emit(object_tokens.type())

func _file_save_path(object_tokens: ASObjectTokens, loader: bool) -> String:
	var suffix := ".gd" if not _save_to_text_files else ".txt"
	var object_type := "_loader" if loader else "_saver"
	var object_name := ASCaseChange.snake(object_tokens.type())
	
	var save_path := ASPathLib.join(_outdir, object_name + object_type + suffix)
	return save_path

func _write_loaders(context: ASWriterContext) -> void:
	for object_tokens in context.object_tokens():
		var filepath := _file_save_path(object_tokens, true)
		var writer := ASLoaderFileWriter.new(filepath, object_tokens, context)
		writer.write()
		
		loader_written.emit(object_tokens.type())
