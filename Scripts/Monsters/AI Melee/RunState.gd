extends Node

var AIController
var run: bool = false

func _ready() -> void:
	AIController = get_parent().get_parent()
	if AIController.Attacking:
		AIController.Attacking = false
		await AIController.get_node("AnimationTree").animation_finished
	else: 
		AIController.get_node("AnimationTree").get("parameters/playback").travel("Awaken")
		AIController.Awakening = true
		await AIController.get_node("AnimationTree").animation_finished
	run = true
	AIController.Awakening = false
	AIController.get_node("AnimationTree").get("parameters/playback").travel("Run")

func _physics_process(delta: float) -> void:
	print("is run? " + str(run))
	if AIController and run:
		print("should run")
		AIController.velocity.x = AIController.direction.x * AIController.SPEED
		AIController.velocity.z = AIController.direction.z * AIController.SPEED
		AIController.look_at(AIController.global_transform.origin + AIController.direction, Vector3(0, 1, 0))
		
