class_name ASSerdeFileWriter


var _filepath: String
var _obj_tokens: ASObjectTokens
var _context: ASWriterContext


func _init(filepath: String, obj_tokens: ASObjectTokens, context: ASWriterContext):
	_filepath = filepath
	_obj_tokens = obj_tokens
	_context = context


func write() -> void:
	push_error("ASSerdeFileWriter.write method is meant to be overridden")
