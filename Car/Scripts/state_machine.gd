class_name State_Machine extends Node

var states : Array[ State ]
var prev_state : State
var current_state : State
var next_state : State

## Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState( current_state.Process( delta )) #return null or state
	pass

## Basing it off the change state
func _physics_process(delta: float) -> void:
	ChangeState( current_state.Physics( delta )) 
	pass
	
## Basing it off the change state
func _unhandled_input(event: InputEvent):
	ChangeState( current_state.HandleInput( event ))
	return null
		
## Initalize the player state based on what is in the states array
func Initailize( _player : Racing_Car ) -> void:
	states = []
	for c in get_children():
		if c is State:
			states.append(c)
			
	if states.size() == 0:
		return
	
	states[0].car = _player
	states[0].state_machine = self
	
	for state in states:
		state.init()
	
	ChangeState( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT

## Actually changing the state, but we don't know what it is though
func ChangeState( new_state : State ) -> void:
	if new_state == null || new_state == current_state: #doesn't change
		return
	
	next_state = new_state
	
	# Exit the current state
	if current_state:
		current_state.exit()
		
	# Enter the new state
	prev_state = current_state
	current_state = new_state
	current_state.enter()
