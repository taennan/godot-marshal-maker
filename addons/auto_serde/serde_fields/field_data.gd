class_name ASFieldData


enum Type {
	INT,
	STR,
	BOOL,
	VARIANT,
	COMPLEX,
}


static func primitve(n: String, t: Type) -> ASFieldData:
	return ASFieldData.new(n, t)

static func complex(n: String) -> ASFieldData:
	return ASFieldData.new(n, Type.COMPLEX)


var name: String
var type: Type


func _init(n: String, t: Type):
	name = n
	type = t
