# TODO:
# - Add class renaming
# - Add auto case changing

#![marshal_maker]
class_name _MMFileWriterTestRenameObject


#[marshal_maker rename=renamedExportVar]
@export var renamed_export_var := 7

#[marshal_maker rename=renamedVar]
var renamed_var := 7

#[marshal_maker rename=RenamedArray]
var renamed_array: Array[Vector2] = []
