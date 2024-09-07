#![marshal_maker]
class_name _MMFileWriterTestIgnoreIncludeObject


#[marshal_maker ignore]
@export var ignored_export_var: int = 0

var ignored_var := 10

#[marshal_maker]
var included_var := '3BusyBees'

class _IgnoredInternalClass:
	
	@export var field_1 := "ignore me!"
	
	#[marshal_maker]
	var field_2 := "ignore me too!"
