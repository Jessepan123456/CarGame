class_name UnBlock extends Area2D

@export var IsBlock : bool = true
@onready var block: Node2D = $"."


func _ready() -> void:
	area_entered.connect( entered )
	pass
	
func entered( _a: Area2D ) -> void:
	if IsBlock == true:
		GlobalGameSignal.Block = false
	if IsBlock == false:
		GlobalGameSignal.Block = true
