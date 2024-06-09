class_name Player_Jump_State extends PlayerState

func enter_state() -> void:
	# Override this method in each state script
	Entity.handle_jump()
	
func exit_state() -> void:
	# Override this method in each state script
	pass

func unhandled_state_input(event) -> void:
	Entity.handle_input(event)

func physics_update(delta) -> void:
	# Override this method in each state script if needed
	Entity.handle_movement(delta)

func update(_delta) -> void:
	# Override this method in each state script if needed
	pass

func get_next_state() -> int:
	
	if Entity.was_grounded:
		if Entity.direction != Vector3.ZERO and Input.is_action_pressed("Sprint") and Entity.movement_dir > -0.5:
			return States.Sprint
		
		if Entity.direction != Vector3.ZERO:
			return States.Walk
	else:
		return States.Idle
	return Key
