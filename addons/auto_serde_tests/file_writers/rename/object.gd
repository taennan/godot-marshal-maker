# TODO:
# - Add class renaming
# - Add auto case changing

#![auto_serde]
class_name _ASFileWriterTestRenameObject


#[auto_serde rename=renamedExportVar]
@export var renamed_export_var := 7

#[auto_serde rename=renamedVar]
var renamed_var := 7

#[auto_serde rename=RenamedArray]
var renamed_array: Array[Vector2] = []
