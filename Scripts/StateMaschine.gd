extends Node

var state = {
	"Idle": preload("res://Scripts/IdleState.gd"),
	"Run": preload("res://Scripts/RunState.gd"),
	"Attack": preload("res://Scripts/AttackState.gd"),
	"Death": preload("res://Scripts/DeathState.gd"),
}

func change_state(new_state_name):
	if get_child_count() != 0:
		get_child(0).free()
		
	if state.has(new_state_name):
		var state = state[new_state_name].new()
		state.name = new_state_name
		add_child(state)
	
