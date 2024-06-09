class_name Player extends CharacterBody3D

@export_subgroup("Properties")
@export var controller_sensitivity : float = 0.05
@export var sensitivity : float = 0.01
@export var walk_speed : float = 5.0
@export var crouch_speed : float = 3.0
@export var sprint_speed : float = 6.5
var movement_speed : float = 0.0
@export var move_acceleration : int = 14
@export var move_deceleration : int = 10
@export var jump_force : float = 3.2
@export var crouch_transition_speed : float = 4
var jump_vector : Vector3 = Vector3.UP
var gravity_vector : Vector3 = Vector3.DOWN 
var gravity : float = 9.8

@export_subgroup("Misc")
@export var allow_fly_movement : bool = false
@export var crouch_shapecast : ShapeCast3D
@export var horizontal : Node3D
@export var vertical : Node3D
@export var animator : AnimationPlayer

var crouch_state : bool = false
var movement_dir : float = 0
var mouse_motion : Vector2 = Vector2.ZERO
var direction : Vector3 = Vector3.ZERO
var was_grounded : bool = true
var is_grounded : bool = true
var has_jumped : bool = false

func _ready() -> void:
	
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.set_use_accumulated_input(false)



func handle_input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_motion = -event.relative * 0.1 * sensitivity
		handle_rotation(mouse_motion)
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func handle_rotation(_mouse_motion : Vector2) -> void:
	rotate_y(_mouse_motion.x)
	horizontal.rotate_y(_mouse_motion.x)
	vertical.rotate_x(_mouse_motion.y)
	vertical.rotation.x = clampf(vertical.rotation.x,-PI * 0.5, PI * 0.5)

func handle_movement(delta : float) -> void:
	var key_input : Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	was_grounded = is_grounded
	
	# For checking speed direction
	movement_dir = -transform.basis.z.dot(velocity.normalized())
	# For checking the actual direction of the player
	direction = transform.basis * (Vector3(key_input.x,0,key_input.y).normalized())
	# Applying the speed to the direction
	var speed_dir : Vector3 = direction * movement_speed
	
	if is_on_floor() or direction != Vector3.ZERO:
		is_grounded = true
		has_jumped = false
		var acceleration : float = move_acceleration if speed_dir.dot(velocity) else move_deceleration
		var vp : Vector3 = gravity_vector.normalized() * velocity.dot(gravity_vector)
		velocity = (velocity - vp).lerp(speed_dir, acceleration * delta) + vp
	
	if not is_on_floor():
		velocity += gravity_vector * gravity * delta
		is_grounded = false

	move_and_slide()

func handle_jump() -> void:
	has_jumped = true
	velocity += jump_vector * jump_force - (jump_vector * -1).normalized() * velocity.dot(jump_vector * -1)

func handle_dir_movement() -> void:
	if is_on_floor():
		if movement_dir < -0.5:
			movement_speed = walk_speed * 0.7
		else:
			movement_speed = walk_speed



