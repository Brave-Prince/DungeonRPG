extends Node

var ai_controller
var run: bool = false

func _ready() -> void:
	ai_controller = get_parent().get_parent()
	
	if ai_controller.Attacking:
		ai_controller.get_node("AnimationTree")
		#await ai_controller.get_node("AnimationTree").animation_finished
		ai_controller.Attacking = false
	else: 
		ai_controller.Awakening = true
		ai_controller.get_node("AnimationTree").get("parameters/playback").travel("Awaken")
		await ai_controller.get_node("AnimationTree").animation_finished
		ai_controller.Awakening = false
	
	run = true
	ai_controller.get_node("AnimationTree").get("parameters/playback").travel("Run")

func _physics_process(_delta: float) -> void:
	if ai_controller and run:
		ai_controller.velocity.x = ai_controller.direction.x * ai_controller.SPEED
		ai_controller.velocity.z = ai_controller.direction.z * ai_controller.SPEED
		ai_controller.look_at(ai_controller.global_transform.origin + ai_controller.direction, Vector3(0, 1, 0))
		
