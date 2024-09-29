extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var state_controller = get_node("StateMaschine")

@export var player: CharacterBody3D

var direction: Vector3
var Awakening: bool = false
var Attacking: bool = false
var health: int = 4
var damage: int = 2
var dying: bool = false
var just_hit: bool = false

func _ready() -> void:
	state_controller.changeState("Idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if player:
		direction = (player.global_transform.origin - self.global_transform.origin).normalized()
	move_and_slide()


func _on_just_hit_timeout() -> void:
	just_hit = false


func _on_chase_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.changeState("Run")


func _on_chase_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.changeState("Idle")


func _on_attack_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.changeState("Attack")


func _on_attack_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.changeState("Run")


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "Awaken" in anim_name:
		Awakening = false
	elif "Attack" in anim_name:
		if (player in get_node("attack_player_detection").get_overlapping_bodies()) and !dying:
			state_controller.changeState("Attack")
	elif "Death" in anim_name:
		death()
		
func death():
		self.queue_free()
		
			
