class_name HeadBobHandler extends Node

@export_group("Head bobbing Parameters")
@export var frequency : float = 1.4
@export var amplitude : float = 0.06
var rate : float = 0.0
@export_subgroup("Misc")
@export var player : Player
@export var camera_container : Node3D
@export var stab_target : Marker3D

func _physics_process(delta):
	head_bobbing(delta)
	#camera_stabilisation() # Broken because of look_at

func head_bobbing(delta : float) -> void:
	if player.direction != Vector3.ZERO and player.was_grounded:
		rate += player.velocity.length() * delta
		var motion = bob_motion()
		
		camera_container.transform.origin = lerp(camera_container.transform.origin,motion,20 * delta)
		
	elif player.direction == Vector3.ZERO or not player.was_grounded:
		restart_camera(delta)

func bob_motion() -> Vector3:
	var pos = Vector3.ZERO
	pos.y = -abs(sin(rate * frequency) * amplitude)
	pos.x = sin(rate * frequency) * amplitude
	return pos


func restart_camera(delta):
	if camera_container.transform.origin == Vector3.ZERO: return
	camera_container.transform.origin = camera_container.transform.origin.lerp(Vector3.ZERO,10 * delta)
	rate = 0.0

func camera_stabilisation() -> void:
	camera_container.look_at(stab_target.global_position)
