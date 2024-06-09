# Rename statemachine to something like player_statemachine
class_name PlayerStateMachine extends Node

# Add the states you want the object to have
enum Entity_States {Idle,Walk,Sprint,Crouch,Jump,Fall,Death}
@export var Entity : Player # if your object is a class replace characterbody3d with it.
@export var Inital_State : Entity_States
var States = {}
var Current_State : PlayerState # Replace this from the template state script
var current_state_id : Entity_States

func _ready():
	Register_States()
	Current_State = States[Inital_State]

# Use the Add State function to add states to the machine.
func Register_States() -> void:
	# Add a state so the object can transition to them
	Add_State(Player_Idle_State.new(),Entity_States.Idle)
	Add_State(Player_Walk_State.new(),Entity_States.Walk)
	Add_State(Player_Sprint_State.new(),Entity_States.Sprint)
	Add_State(Player_Jump_State.new(),Entity_States.Jump)
	Add_State(Player_Crouch_State.new(),Entity_States.Crouch)
	Add_State(Player_Death_State.new(),Entity_States.Death)

# A add state function so we can add the states to our states dictionary
func Add_State(New_State : PlayerState, Enum_State : Entity_States) -> void:
	New_State.Entity = Entity
	New_State.States = Entity_States
	New_State.Key = Enum_State
	States[Enum_State] = New_State

func _unhandled_input(event) -> void:
	Current_State.unhandled_state_input(event)

func _process(delta : float) -> void:
	Current_State.update(delta)
	
func _physics_process(delta : float) -> void:
	Current_State.physics_update(delta)
	var next_state = Current_State.get_next_state()
	
	if next_state != Current_State.Key:
		transition_to_state(next_state)

func transition_to_state(next_state : Entity_States) -> void:
	current_state_id = next_state
	Current_State.exit_state()
	Current_State = States.get(next_state)
	Current_State.enter_state()
	

