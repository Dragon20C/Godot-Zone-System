class_name Prompt extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.prompt = self
	clear_message()

func set_message(message : String) -> void:
	text = message

func clear_message() -> void:
	text = ""

