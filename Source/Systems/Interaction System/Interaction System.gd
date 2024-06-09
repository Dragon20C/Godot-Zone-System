class_name InteractionHandler extends Node

@export var detect_area : Area3D
@export var raycast : RayCast3D

var current_interactable_area : InteractableArea3D

func _process(delta):
	check_area()
	

func check_area() -> void:
	if current_interactable_area != null and Input.is_action_just_pressed("Interact"):
		current_interactable_area.Interact()
		# Check for updates to the prompt message
		if Global.prompt.text != current_interactable_area.Message:
			Global.prompt.set_message(current_interactable_area.Message)
		
	# If we are not overlapping an area we dont need to continue
	if not detect_area.has_overlapping_areas() and Global.prompt.visible: 
		Global.prompt.visible = false
		# We set current to null if we are not detecting an area
		current_interactable_area = null 
		return
	
	# If we already have an area no need to continue, saves some resources
	if current_interactable_area != null: return 
	
	for area in detect_area.get_overlapping_areas():
		if area is InteractableArea3D:
			current_interactable_area = area
			Global.prompt.set_message(area.Message)
			#Global.prompt.text = area.Prompt_Message
			Global.prompt.visible = true
			return

