class_name MM_TYPES


const INT := "int"
const FLOAT := "float"
const BOOL := "bool"
const STRING := "String"

const VARIANT := "Variant"

const VECTOR_2 := "Vector2"
const VECTOR_2I := "Vector2i"
const VECTOR_3 := "Vector3"
const VECTOR_3I := "Vector3i"
const COLOR := "Color"

const PRIMITIVE := [INT, FLOAT, BOOL, STRING]
const SIMPLE := [VECTOR_2, VECTOR_2I, VECTOR_3, VECTOR_3I, COLOR]

# TODO: Add all the builtin resource types
const RESOURCE := [
	"Animation",
	"AnimationLibrary",
	"AudioStreamMP3",
	"AudioStreamWAV",
	"Texture2D",
	"Theme",
]
