extends Area3D

@export var trauma_amount : float = 1

#Calling this method will check for all shakeable cameras the "trauma causer" overlaps with, then increase the screenshake intensity.
func cause_trauma():
	var trauma_areas := get_overlapping_areas()
	for area in trauma_areas:
		if area.has_method("add_trauma"):
			area.add_trauma(trauma_amount)
