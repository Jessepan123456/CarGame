class_name Lamp extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	if GlobalGameSignal.Is_night == false:
		animation_player.play("default")
	else:
		_play_night()
		
func _play_night() -> void:
	animation_player.play("light")
