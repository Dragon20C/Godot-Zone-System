class_name Player_Death_State extends PlayerState

func enter_state() -> void:
	Entity.animator.play("Death")
	print("Oh I am dead!")
	
func exit_state() -> void:
	# Override this method in each state script
	pass

func unhandled_state_input(_event) -> void:
	pass

func physics_update(_delta) -> void:
	pass

func update(_delta) -> void:
	# Override this method in each state script if needed
	pass

func get_next_state() -> int:
	return Key
