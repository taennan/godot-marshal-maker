#![marshal_maker]
class_name _MMFileWriterTestPrimitiveObject


@export var specified_string: String = """triple-string-thing"""

@export var inferred_single_double_string := "Apple"

@export var inferred_single_single_string := 'Apfel'

@export var inferred_triple_double_string := """Appel"""

@export var inferred_triple_single_string := '''Pomme'''

@export var inferred_raw_single_double_string := r"Apple"

@export var inferred_raw_single_single_string := r'Apfel'

@export var inferred_raw_triple_double_string := r"""Appel"""

@export var inferred_raw_triple_single_string := r'''Pomme'''


@export var specified_float: float = 0.0

@export_range(0.0, 1.0) var inferred_float := 3.14


@export var specified_int: int = 123

@export var inferred_int := 9000

@export var inferred_int_with_underscore := 10_000

@export var inferred_binary := 0b0010

@export var inferred_hex := 0x0232aF
