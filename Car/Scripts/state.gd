class_name State extends Node

## Stores a reference to the player that this State belong to
static var car : Racing_Car
static var state_machine: State_Machine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init() -> void:
	pass

## What happens when the player enters this state
func enter() -> void:
	pass

## What happen when the player exits this state
func exit() -> void:
	pass
	
## What happen during the _process update in this state
func Process( _delta : float) -> State:
	return null
	
## What happen during the _physics_process update in this State
func Physics( _delta : float) -> State:
	return null
	
## What happen with input events in this state
func HandleInput( _event : InputEvent) -> State:
	return null
	
