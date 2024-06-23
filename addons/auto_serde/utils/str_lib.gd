class_name ASStrLib


const WHITESPACE_CHARS := " \t\n\r"


static func strip_edge_chars(str: String, chars: String) -> String:
	return str.lstrip(chars).rstrip(chars)

static func regex(pattern: String) -> RegEx:
	var re := RegEx.new()
	re.compile(pattern)
	return re
