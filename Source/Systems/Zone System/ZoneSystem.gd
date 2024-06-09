extends Node3D
class_name ZoneSystem

@export var disable : bool = false
var chunks : Array[Node] # Array of Chunks
var current_chunk : Chunk

func _ready() -> void:
	chunks = get_children()

func set_chunk(chunk_node : Chunk) -> void:
	if disable: return
	current_chunk = chunk_node
	update_chunks()

func update_chunks() -> void:
	# Loop through the chunks and disable all of them
	# Kind of inefficient since we want to disable just previous naighbour
	# and far away naighbours
	 
	for chunk in chunks:
		chunk.get_child(0).find_child("StaticBody3D").process_mode = Node.PROCESS_MODE_DISABLED
		chunk.visible = false
	
	# Make current visible and loop through its neihbours
	current_chunk.visible = true
	current_chunk.get_child(0).find_child("StaticBody3D").process_mode = Node.PROCESS_MODE_INHERIT
	for neighbour in current_chunk.neighbours:
		neighbour.visible = true
		neighbour.get_child(0).find_child("StaticBody3D").process_mode = Node.PROCESS_MODE_INHERIT
