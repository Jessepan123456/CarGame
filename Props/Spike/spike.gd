class_name Spike extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("default")
	$HitBox.Damaged.connect( disabled )
	
func disabled( _hurtbox : HurtBox ) -> void:
	animation_player.play("gone")
	$HurtBox.set_deferred("monitoring", false)
	$HitBox.set_deferred("monitorable", false)
	
	await get_tree().create_timer( 3.0 ).timeout
	respawn()
	
func respawn() -> void:
	animation_player.play("default")
	$HurtBox.set_deferred("monitoring", true)
	$HitBox.set_deferred("monitorable", true)
	
