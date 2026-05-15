class_name GrabBox extends Area2D

signal PickUp( hurt_box : HurtBox )

##Send a signal that hitbox enter a hurtbox area
func Pick( hurt_box : HurtBox ) -> void:
	PickUp.emit( hurt_box )
	pass
