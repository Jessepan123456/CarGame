class_name State_Drive extends State

@export var speed : float = 150

@onready var crash: State_Crash = $"../Crash"
@onready var idle: State_Idle = $"../idle"
@onready var speed_up: State_Speedup = $"../SpeedUp"
@onready var drive_stream: AudioStreamPlayer2D = $"../../Audio/DriveStream"
@onready var trail_1: Line2D = $"../../Trail1"
@onready var trail_2: Line2D = $"../../Trail2"

## What happens when the player enters this state
func enter() -> void:
	car.speed_up = false
	
	#car.updateAnimation("drive")
	drive_stream.play()
	trail_1.visible = true
	trail_2.visible = true
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	#Speed energy and bar
	car.speed_energy = min(car.speed_energy + car.regen_energy * _delta, car.max_energy)
	car.update_speed_bar(car.regen_energy * _delta)
	
	#Not moving
	if car.direction == Vector2.ZERO:
		drive_stream.stop()
		trail_1.visible = false
		trail_2.visible = false
		return idle
		
	## Died
	if car.hp <= 0:
		return crash	
		
	car.velocity = car.direction * speed
	#if car.set_direction():
		##car.updateAnimation("drive")
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("speedup"):
		drive_stream.stop()
		car.speed_up = true
		return speed_up
	return null
	
