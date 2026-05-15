class_name State_Speedup extends State

@export var increase_speed : float = 300.0

@onready var crash: State_Crash = $"../Crash"
@onready var drive: State_Drive = $"../drive"
@onready var idle: State_Idle = $"../idle"
@onready var speed_stream: AudioStreamPlayer2D = $"../../Audio/SpeedStream"

## What happens when the player enters this state
func enter() -> void:
	#car.updateAnimation("speed")
	car.speed_up = true
	speed_stream.play()
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	#Speed energy and bar
	car.speed_energy -= car.drain_energy * _delta
	car.update_speed_bar(-car.drain_energy * _delta)
	
	#If you ran out of speed you can't anymore
	if car.direction == Vector2.ZERO:
		speed_stream.stop()
		return idle
	if car.speed_energy <= 0:
		speed_stream.stop()
		return drive
	if car.hp <= 0:
		return crash	
			
	car.velocity = car.direction * increase_speed
	
	#if car.set_direction():
		##car.updateAnimation("speed")
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_released("speedup"):
		car.speed_up = false
		return drive
	return null
	
