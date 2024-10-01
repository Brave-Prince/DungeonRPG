extends CanvasLayer


func _ready() -> void:
	get_node("container").hide()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		get_node("container").visible = get_tree().paused
		match get_tree().paused:
			true:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			false:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				
		


func _on_inventory_button_pressed() -> void:
	get_node("container/VBoxContainer/inventory_button").disable = true
	get_node("container/VBoxContainer/profile_button").disable = false
	get_node("container/inventory").show()
	get_node("container/profile").hide()

func _on_profile_button_pressed() -> void:
	get_node("container/VBoxContainer/inventory_button").disable = false
	get_node("container/VBoxContainer/profile_button").disable = true
	get_node("container/inventory").hide()
	get_node("container/profile").show()
