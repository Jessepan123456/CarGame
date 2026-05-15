class_name Repair extends Node2D

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
	var hurt = _hurtbox.car
	
	if hurt is Racing_Car:
		hurt.update_hp(1)
	$Sprite2D.set_deferred("visible", false)
	$GrabBox.set_deferred("monitorable", false)
	
