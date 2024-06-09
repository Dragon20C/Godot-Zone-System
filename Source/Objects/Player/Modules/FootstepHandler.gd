extends Node

# The footstep sound effect.
@export var footstep_sound : Array[AudioStream]
# The landing sound effect.
@export var jumping_sound : AudioStream
@export var landing_sound : AudioStream

@export var audio_emitter : AudioStreamPlayer3D
# The player node to follow.
@export var player : CharacterBody3D
var stored_time : float = 0.0

# The last frame the player was on the floor.
var last_on_floor : bool = false

# The delay between footstep sounds.
@export var footstep_delay : float = 0.32
# The time of the last footstep.
var last_footstep_time = 0.0

func _physics_process(delta):
	
	
	# Check if the player is on the floor.
	var on_floor = player.was_grounded
	
	if player.velocity.length() > 0 and on_floor:
		stored_time += player.velocity.length() * 0.15 * delta # OOH Magic numbers
	# If the player was on the floor last frame and is not on the floor this frame,
	# play the landing sound effect.
	if not last_on_floor and on_floor: # Landing
		audio_emitter.stream = landing_sound
		audio_emitter.play()
	elif last_on_floor and player.has_jumped: # Jumping
		audio_emitter.stream = jumping_sound
		audio_emitter.play()
	last_on_floor = on_floor
	
	if not on_floor: return
	
	handle_footsteps()


func handle_footsteps() -> void:
	# Check if the player is moving and enough time has passed since the last footstep.
	if player.velocity.length() > 0 and stored_time > last_footstep_time + footstep_delay:
		# Play the footstep sound effect.
		audio_emitter.stream = get_rand_sound()
		audio_emitter.pitch_scale = randf_range(0.9,1.1)
		audio_emitter.play()
		# Reset the last footstep time.
		last_footstep_time = stored_time

func get_rand_sound() -> AudioStream:
	return footstep_sound.pick_random()
