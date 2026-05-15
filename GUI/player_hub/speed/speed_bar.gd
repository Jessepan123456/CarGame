class_name SpeedGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

## Number of frames
var value : int = 12 :
	set( _value ): #everytime the value update
		value = _value
		update_sprite()

## Sprite update
func update_sprite() -> void:
	sprite.frame = value
