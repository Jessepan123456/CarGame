class_name State_Idle extends State

@onready var crash: State_Crash = $"../Crash"
@onready var drive: State_Drive = $"../drive"
@onready var stop_stream: AudioStreamPlayer2D = $"../../Audio/StopStream"
@onready var trail_1: Line2D = $"../../Trail1"
@onready var trail_2: Line2D = $"../../Trail2"

## What happens when the player enters this state
func enter() -> void:
	#car.updateAnimation("idle")
	car.speed_up = false
	
	stop_stream.play()
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	#Speed energy and bar
	car.speed_energy = min(car.speed_energy + car.regen_energy * _delta, car.max_energy)
	car.update_speed_bar(car.regen_energy * _delta)
	
	if car.direction != Vector2.ZERO:
		stop_stream.stop()
		trail_1.visible = false
		trail_2.visible = false
		return drive
		
	if car.hp <= 0:
		return crash	
		
	car.velocity = Vector2.ZERO
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	return null
	
