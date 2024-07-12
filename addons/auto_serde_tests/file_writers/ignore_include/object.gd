#![auto_serde]
class_name _ASFileWriterTestIgnoreIncludeObject


#[auto_serde ignore]
@export var ignored_export_var: int = 0

var ignored_var := 10

#[auto_serde]
var included_var := '3BusyBees'

class _IgnoredInternalClass:
	
	@export var field_1 := "ignore me!"
	
	#[auto_serde]
	var field_2 := "ignore me too!"
