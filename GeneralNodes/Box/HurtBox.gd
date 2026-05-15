class_name HurtBox extends Area2D

@export var car : Node
@export var damage : int = 1

#var can_take_damage := true

func _ready() -> void: 
	area_entered.connect(AreaEntered)
	pass
	
##If a hitbox enter the hurtbox area
func AreaEntered( _a : Area2D ) -> void:
	if _a is HitBox:
		_a.Take_Damaged( self )
	if _a is GrabBox:
		_a.Pick( self )
	pass
