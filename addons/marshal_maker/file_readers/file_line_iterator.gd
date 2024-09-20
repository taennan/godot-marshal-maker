class_name MMFileLineIterator


var _filepath := ""

class _Iterator:
	var _file: FileAccess
	
	func _init(filepath: String):
		_file = FileAccess.open(filepath, FileAccess.READ)
	
	func is_done() -> bool:
		return _file.get_position() >= _file.get_length()
	
	func next() -> String:
		return _file.get_line()


func _init(filepath: String):
	_filepath = filepath


func iter(fn: Callable) -> void:
	var iterator := _Iterator.new(_filepath)
	while not iterator.is_done():
		var line := iterator.next()
		fn.callv([line])

func filter_lines(fn: Callable) -> String:
	var text := ""
	var iterator := _Iterator.new(_filepath)
	while not iterator.is_done():
		
		var line := iterator.next()
		var predicate_result: bool = fn.callv([line])
		if predicate_result:
			text += line
	
	return text

func has_line(fn: Callable) -> bool:
	var iterator := _Iterator.new(_filepath)
	while not iterator.is_done():
		
		var line := iterator.next()
		var predicate_result: bool = fn.callv([line])
		if predicate_result:
			return true
		
	return false

func find_line(fn: Callable) -> MMOption:
	var iterator := _Iterator.new(_filepath)
	while not iterator.is_done():
		
		var line := iterator.next()
		var predicate_result: bool = fn.callv([line])
		if predicate_result:
			return MMOption.some(line)
		
	return MMOption.none()
	
