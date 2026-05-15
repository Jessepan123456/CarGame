class_name Racing_Car extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: State_Machine = $StateMachine
@onready var hit_box: HitBox = $HitBox
@onready var hurt_box: HurtBox = $HurtBox
@onready var hurt_particles: GPUParticles2D = $hurt_particles
@onready var car_light: PointLight2D = $CarLight

## Skins
@export var skins: Array[Texture2D]
@onready var sprite_2d: Sprite2D = $Sprite2D
var current_skin = 0


const DeathMenu : String = "res://GUI/death_hub/DeathHub.tscn"
const DIR_8 = [ Vector2.RIGHT, Vector2.RIGHT + Vector2.DOWN, 
Vector2.DOWN, Vector2.LEFT + Vector2.DOWN, Vector2.LEFT,
Vector2.LEFT + Vector2.UP, Vector2.UP, Vector2.RIGHT + Vector2.UP ]

## Direction
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

##HP
var hp : int = 10
var max_hp : int = 10

##Energy
var speed_energy : float = 60.0
var regen_energy : float = 10.0
var drain_energy : float = 15.0
var max_energy : float = 60.0

var num : float = 0.0

##Animation Tree Variables
var speed_up : bool = false
var is_dead : bool = false

##Camera
@onready var camera2D: Camera = $Camera2D
var cameraShake : FastNoiseLite

func _ready() -> void:
	CarManager.car = self
	state_machine.Initailize(self)
	hit_box.Damaged.connect( take_damage )
	hurt_box.car = self
	cameraShake = FastNoiseLite.new()
	set_skin(GlobalGameSignal.skin_changed)
	
	# Updates
	update_hp(200)
	update_speed_bar(200)
	pass
	
func _process( _delta: float ) -> void:
	if is_dead == true:
		return
	if CarManager.can_control == true:
		num += _delta
		PlayerHub.update_timer(num)
		if GlobalGameSignal.endless == false:
			direction = Vector2( #Direction
				Input.get_axis("left", "right"),
				Input.get_axis("up", "down")
			).normalized()
		else:
			#Endless
			direction = Vector2( #Direction
				Input.get_axis("left", "right"),
				Input.get_axis("up", "down")
			).normalized()
			camera2D.enabled = false

	# Car Lights
	if Input.is_action_just_pressed("CarLight"):
		if car_light.visible == false:
			car_light.visible = true
		else:
			car_light.visible = false
	pass
	
## Velocity
func _physics_process(_detla):
	move_and_slide() #allow us to move with velocity

### Animation
func set_direction() -> bool:
	# Never moved
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_8.size() ) )
	var new_dir = DIR_8[ direction_id ]
	
	#Same
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	return true

## Update hp
func update_hp( delta : int ) -> void:
	hp = clampi( hp + delta, 0, max_hp) #boundary to 0 to max
	PlayerHub.update_hp(hp, max_hp)
	
## Update speed bar
func update_speed_bar( delta : float ) -> void:
	speed_energy = clamp( speed_energy + delta, 0, max_energy )
	PlayerHub.update_bar( speed_energy, max_energy )

## What happen when you take damage
func take_damage( hurtbox : HurtBox ) -> void:
	#Death
	if hp <= 0:
		get_tree().call_deferred("change_scene_to_file", DeathMenu)
	# Alive
	if hp > 0:
		# Camera
		var camera_tween = get_tree().create_tween()
		camera_tween.tween_method(startCameraShake, 3.0, 1.0, 0.5)
		
		# hurt particles
		hurt_particles.restart()
		hurt_particles.emitting = true
		
		# Damaged
		var knock_dir = -cardinal_direction.normalized()
		velocity += knock_dir * 300
		$".".modulate = Color.RED
		update_hp( -hurtbox.damage )
		await get_tree().create_timer(0.3).timeout
		$".".modulate = Color.WHITE
		# Make sure you don't stay red

	
		#After taken  damage
		if hp <= 0:
			get_tree().call_deferred("change_scene_to_file", DeathMenu)

## Camera Shake
func startCameraShake( intensity : float ) -> void:
	var cameraOffSet = cameraShake.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera2D.offset.x = cameraOffSet
	camera2D.offset.y = cameraOffSet

func set_skin( id : int) -> void:
	print("Hi")
	current_skin = id
	sprite_2d.texture = skins[id]

	
