extends Area3D
class_name Chunk

@onready var zone_system : ZoneSystem = get_parent()
@export var neighbours : Array[Chunk]

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		zone_system.set_chunk(self)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		pass
