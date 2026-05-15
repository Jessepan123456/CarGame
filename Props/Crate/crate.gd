class_name Crate extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("default")
	$HitBox.Damaged.connect( remove )
	PlayerHub.reach_lap.connect( reset )
	
func reset() -> void:
	animation_player.play("default")
	$HurtBox.set_deferred("monitoring", true)
	$Sprite2D.set_deferred("visible", true)
	$StaticBody2D.collision_layer = 2
	
func remove( _hurtbox : HurtBox ) -> void:
	animation_player.play("destory")
	$HurtBox.set_deferred("monitoring", false)
	await animation_player.animation_finished
	$Sprite2D.set_deferred("visible", false)
	$StaticBody2D.collision_layer = 0
