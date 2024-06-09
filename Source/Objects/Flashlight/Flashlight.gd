extends SpotLight3D

@export_subgroup("Sway")
var mouse_motion : Vector2
@export var sway_amount : float = 0.005
@export var max_pos_sway_amount : Vector3 = Vector3(0.001,0.0,0.0)
@export var max_rot_sway_amount : Vector3 = Vector3(0.01,0.1,0.1)
@export var sway_pos_speed : float = 5.0
@export var sway_rot_speed : float = 8.0
@export var sway_return_speed : float = 18.0

var sway_rot : Vector3 = Vector3.ZERO
var sway_pos : Vector3 = Vector3.ZERO

func _unhandled_input(event):
	if not visible: return
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion = -event.relative * sway_amount

func _process(delta):
	if Input.is_action_just_pressed("Flashlight"):
		visible = !visible
		AudioHandler.play(AudioHandler.audio.switch_sfx)
	
	if not visible: return
	handle_sway(delta)
	position = sway_pos
	rotation = sway_rot
	
func handle_sway(delta : float) -> void:
	mouse_motion = lerp(mouse_motion,Vector2.ZERO,sway_return_speed * delta)
	
	var inital_sway_pos = Vector3(mouse_motion.x,mouse_motion.y,0)
	var inital_sway_rot = Vector3(mouse_motion.y,mouse_motion.x,mouse_motion.x)
	
	inital_sway_pos = inital_sway_pos.clamp(-max_pos_sway_amount,max_pos_sway_amount)
	inital_sway_rot = inital_sway_rot.clamp(-max_rot_sway_amount,max_rot_sway_amount)
	
	sway_pos = sway_pos.lerp(inital_sway_pos, sway_pos_speed * delta)
	sway_rot = sway_rot.lerp(inital_sway_rot, sway_rot_speed * delta)
