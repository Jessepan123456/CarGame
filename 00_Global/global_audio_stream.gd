extends AudioStreamPlayer2D

@onready var global_audio: AudioStreamPlayer2D = $"."

func _ready() -> void:
	global_audio.play()
