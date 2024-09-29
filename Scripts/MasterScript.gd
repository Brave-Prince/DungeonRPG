# General script to handle global logic like Esc to exit...

extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Esc"):
		get_tree().quit()
