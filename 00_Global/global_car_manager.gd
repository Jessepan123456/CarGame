extends Node

const CAR = preload("uid://msln043dk2l4")

var car : Racing_Car
var player_spawned : bool = false
var can_control : bool = true

func _ready() -> void:
	add_player()

func add_player() -> void:
	await get_tree().create_timer(0.5).timeout
	player_spawned = true

## Set up the health
func set_health( hp: int, max_hp: int ) -> void:
	car.max_hp = max_hp
	car.hp = hp
	##UI update
	car.update_hp( 0 )

## Set up the speed bar
func set_speedbar( energy : int, max_energy: int ) -> void:
	car.max_energy = max_energy
	car.speed_energy = energy
	##UI update
	car.update_speed_bar( 0 )

func position( pos : Vector2 ) -> void:
	car.global_position = pos
	pass
	
