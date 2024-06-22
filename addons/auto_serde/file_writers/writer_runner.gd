class_name ASWriterRunner


var _srcdir: String
var _outdir: String
var _temp_outdir := ""


func _init(srcdir: String, outdir: String):
	_srcdir = srcdir
	_outdir = outdir


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

func _delete_temp_outdir() -> void:
	OS.move_to_trash(_temp_outdir)
	_temp_outdir = ""


func _write_new_outdir() -> void:
	DirAccess.make_dir_absolute(_outdir)
	
	var writer_context := _get_writer_context()
	_write_savers(writer_context)
	_write_loaders(writer_context)

func _get_writer_context() -> ASWriterContext:
	var context := ASWriterContext.new()
	var marked_files := ASMarkedFileScout.new(_srcdir).get_filepaths()
	
	for file in marked_files:
		var text := FileAccess.get_file_as_string(file)
		var object_tokens := ASObjectTokens.new(text)
		
		if not object_tokens.error():
			context.add_object_tokens(object_tokens)
	
	return context

func _write_savers(context: ASWriterContext) -> void:
	for object_tokens in context.object_tokens():
		var filepath := ASPathLib.join(_outdir, object_tokens.type() + "Saver.gd")
		var writer := ASSaverFileWriter.new(filepath, object_tokens, context)
		writer.write()

func _write_loaders(context: ASWriterContext) -> void:
	for object_tokens in context.object_tokens():
		var filepath := ASPathLib.join(_outdir, object_tokens.type() + "Loader.gd")
		var writer := ASLoaderFileWriter.new(filepath, object_tokens, context)
		writer.write()
