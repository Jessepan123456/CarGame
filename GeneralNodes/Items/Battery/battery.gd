class_name Battery extends Node2D

@export var car : Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$GrabBox.PickUp.connect(Effect)
	PlayerHub.reach_lap.connect( reset )
	animation_player.play("Moving")
	
func reset() -> void:
	$Sprite2D.set_deferred("visible", true)
	$GrabBox.set_deferred("monitorable", true)
	
func Effect( _hurtbox : HurtBox ) -> void:
	var car = _hurtbox.car
	
	if car is Racing_Car:
		car.update_speed_bar(15)
	$Sprite2D.set_deferred("visible", false)
	$GrabBox.set_deferred("monitorable", false)
	
