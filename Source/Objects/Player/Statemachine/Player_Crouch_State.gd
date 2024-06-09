class_name Player_Crouch_State extends PlayerState

func enter_state() -> void:
	# Override this method in each state script
	Entity.movement_speed = Entity.crouch_speed

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
	
	if Input.is_action_just_released("Jump") and not Entity.crouch_shapecast.is_colliding():
		Entity.crouch_state = false
		Entity.handle_crouch()
		return States.Idle
	
	if Input.is_action_just_pressed("Crouch") and not Entity.crouch_shapecast.is_colliding():
		Entity.crouch_state = false
		Entity.handle_crouch()
		return States.Idle
	
	return Key
