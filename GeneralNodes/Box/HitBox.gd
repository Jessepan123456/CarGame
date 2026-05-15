class_name HitBox extends Area2D

signal Damaged( hurt_box : HurtBox )

##Send a signal that hitbox enter a hurtbox area
func Take_Damaged( hurt_box : HurtBox ) -> void:
	Damaged.emit( hurt_box )
	pass
