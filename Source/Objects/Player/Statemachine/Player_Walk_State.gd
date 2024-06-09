class_name Player_Walk_State extends PlayerState

func enter_state() -> void:
	# Override this method in each state script
	pass
	Entity.movement_speed = Entity.walk_speed

func exit_state() -> void:
	# Override this method in each state script
	pass

func unhandled_state_input(event) -> void:
	Entity.handle_input(event)

func physics_update(delta) -> void:
	# Override this method in each state script if needed
	Entity.handle_dir_movement()
	Entity.handle_movement(delta)

func update(_delta) -> void:
	# Override this method in each state script if needed
	pass

func get_next_state() -> int:
	if Input.is_action_just_pressed("Jump") and Entity.is_on_floor():
		return States.Jump
	
	if Entity.direction != Vector3.ZERO and Input.is_action_pressed("Sprint") and Entity.movement_dir > -0.5:
		return States.Sprint
		
	if Entity.direction == Vector3.ZERO:
		return States.Idle
	return Key
