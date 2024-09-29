extends Node

var ai_controller

func _ready() -> void:
	ai_controller = get_parent().get_parent()
	
	if ai_controller.Awakening:
		await ai_controller.get_node("AnimationTree").animation_finished
		
	ai_controller.get_node("AnimationTree").get("parameters/playback").travel("Attack")
	ai_controller.Attacking = true
	ai_controller.look_at(ai_controller.global_transform.origin + ai_controller.direction, Vector3(0, 1, 0))

func _physics_process(_delta):
	if ai_controller:
		ai_controller.velocity.x = 0
		ai_controller.velocity.z = 0
