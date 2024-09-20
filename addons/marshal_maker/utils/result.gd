class_name MMResult


var value = null
var error := false
var error_value = null


static func ok(value = null) -> MMResult:
	var MMResult := MMResult.new()
	MMResult.value = value
	return MMResult

static func err(value = null) -> MMResult:
	var MMResult := MMResult.new()
	MMResult.error = true
	MMResult.error_value = value
	return MMResult
