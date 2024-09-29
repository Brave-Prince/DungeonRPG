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
var Idlying: bool = false
var health: int = 4
var damage: int = 2
var dying: bool = false
var just_hit: bool = false
var is_attacking: bool

func _ready() -> void:
	state_controller.change_state("Idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if player:
		direction = (player.global_transform.origin - self.global_transform.origin).normalized()
		
	move_and_slide()

func _on_chase_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Run")

func _on_chase_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Idle")

func _on_attack_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Attack")

func _on_attack_player_detection_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !dying:
		state_controller.change_state("Run")

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "Awaken" in anim_name:
		Awakening = false
	elif "Attack" in anim_name:
		if (player in get_node("attack_player_detection").get_overlapping_bodies()) and !dying:
			state_controller.change_state("Attack")
	elif "Death" in anim_name:
		death()
		
func death():
		self.queue_free()

func _on_damage_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.hit(damage)
		
func hit(hit_damage: int):
	if !just_hit:
		just_hit = true
		get_node("just_hit").start()
		health -= hit_damage
		if health <=0:
			state_controller.change_state("Death")
		#knockback
		var tween = create_tween()
		tween.tween_property(self, "global_position", global_position - (direction/2), 0.2)

func _on_just_hit_timeout() -> void:
	just_hit = false
