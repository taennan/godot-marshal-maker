class_name Result


var value = null
var error := false
var error_value = null


static func ok(value = null) -> Result:
	var result := Result.new()
	result.value = value
	return result

static func err(value = null) -> Result:
	var result := Result.new()
	result.error = true
	result.error_value = value
	return result
