class_name Player extends CharacterBody2D

var walk_spd = 10.0
const tile_size = 16

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
@onready var ray_cast_2d: RayCast2D = $RayCast2D

@export var inv : Inv

var initial_position = Vector2.ZERO
var input_direction = Vector2.ZERO
var is_moving = false
var per_moved_to_next = 0

enum Move_State  {IDLE, TURNING, WALKING}

enum Facing_Direction { LEFT, RIGHT, UP, DOWN}

var player_state = Move_State.IDLE
var player_facing = Facing_Direction.DOWN

func _ready():
	anim_tree.active = true
	initial_position = position
	if Global.is_elsewhere && Global.player_position_on_transition != Vector2():
		position = Global.player_position_on_transition
		

func _physics_process(delta):
	if player_state == Move_State.TURNING :
		return
	elif is_moving == false:
		process_player_movement_input()
	elif input_direction != Vector2.ZERO:
		anim_state.travel("Walk")
		move(delta)
	else:
		anim_state.travel("Idle")
		is_moving = false

func move(delta):
	
	var is_sprinting = 1 + 2 * int(Input.is_action_pressed("sprint"))
	
	per_moved_to_next += walk_spd * delta * is_sprinting
	
	var desired_pos: Vector2 = tile_size * input_direction / 2
	
	ray_cast_2d.target_position = desired_pos
	ray_cast_2d.force_raycast_update()
	
	if !ray_cast_2d.is_colliding():
	
		if per_moved_to_next >= 1.0 :
			position = initial_position + (tile_size * input_direction)
			per_moved_to_next = 0.0
			is_moving = false
		else:
			position = initial_position + (tile_size * input_direction * per_moved_to_next)
	else:
		is_moving = false
	pass

func process_player_movement_input():
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if input_direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_direction);
		anim_tree.set("parameters/Walk/blend_position", input_direction);
		anim_tree.set("parameters/Turn/blend_position", input_direction);
		
		if need_to_turn():
			player_state = Move_State.TURNING
			anim_state.travel("Turn")
		else:
			initial_position = position
			is_moving = true
	else :
		anim_state.travel("Idle")

func need_to_turn():
	
	var new_facing_direction
	if input_direction.x < 0:
		new_facing_direction = Facing_Direction.LEFT
	elif input_direction.x > 0:
		new_facing_direction = Facing_Direction.RIGHT
	elif input_direction.y > 0:
		new_facing_direction = Facing_Direction.DOWN
	elif input_direction.y < 0:
		new_facing_direction = Facing_Direction.UP
	
	if player_facing != new_facing_direction:
		player_facing = new_facing_direction
		return true
	player_facing = new_facing_direction
	return false

func finished_turning():
	player_state = Move_State.IDLE
	
func collect(item):
	inv.insert(item)
	pass
	
func lose(item, n):
	inv.substract(item,n)
	
func check(item):
	inv.exists(item)
