extends PointLight2D

func _ready() -> void:
	flicker()
	pass
	
## Makes the torches flicker 
func flicker() -> void:
	#Basically by changing the energy level or alpha
	energy = randf() * 0.1 + 0.9
	scale = Vector2( 1, 1 ) * energy
	await get_tree().create_timer( 0.1 ).timeout
	#Calls itself so it keep on doing it
	flicker()
	pass
