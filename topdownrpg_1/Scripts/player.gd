class_name Player extends CharacterBody2D

var walk_spd = 10.0
const tile_size = 16

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var ordering : int = 0
@export var inv : Inv

#signals for followers
signal stopped
signal moving

#parameters for movement
var initial_position = Vector2.ZERO
var input_direction = Vector2.ZERO
var is_moving = false
var per_moved_to_next = 0

#parameters for animation
enum Move_State  {IDLE, TURNING, WALKING}
enum Facing_Direction { LEFT, RIGHT, UP, DOWN}
var player_state = Move_State.IDLE
var player_facing = Facing_Direction.DOWN

func _ready():
	
	sprite_2d.texture = load(Global.chat[ordering])
	
	anim_tree.active = true
	initial_position = position
	if Global.is_elsewhere && Global.player_position_on_transition != Vector2():
		position = Global.player_position_on_transition
	

func _process(_delta):
	sprite_2d.texture = load( Global.chat[Global.chat_order[ordering] ])

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
		player_state = Move_State.IDLE
		is_moving = false
		

func move(delta):
	
	
	var is_sprinting = 1 + 2 * int(Input.is_action_pressed("sprint")) #speed up daca e shift, nu modifica altfel
	
	per_moved_to_next += walk_spd * delta * is_sprinting #idk tbh
	
	var desired_pos: Vector2 = tile_size * input_direction / 2 # nici aici
	
	ray_cast_2d.target_position = desired_pos
	ray_cast_2d.force_raycast_update()
	
	#testing if player can move
	if !ray_cast_2d.is_colliding():
		moving.emit(walk_spd * is_sprinting * 0.265)
		if per_moved_to_next >= 1.0 :
			position = initial_position + (tile_size * input_direction) #fixeaza pozitia 
			per_moved_to_next = 0.0
			is_moving = false #si opreste miscarea
			stopped.emit(position)
		else:
			position = initial_position + (tile_size * input_direction * per_moved_to_next) #misca playerul
			
	else:
		is_moving = false
	pass

func process_player_movement_input():
	
	#practic ca sa se deplaseze doar pe 4 directii
	#trebuie ca o singura valoare din Vector2 sa fie diferita de 0
	#si atunci in prim ca sa dea valoare la x trb y sa fie 0 si vice versa
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	#doar una poate sa ia valoarea 1, si atunci daca right = 1 si left 0 -> (1,0) care intrun sist xy 
	#ar arata spre dreapta, invers pt stanga, si acelasi lucru si la sus si jos, doar ca (0,1) e jos 
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if input_direction != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_direction);
		anim_tree.set("parameters/Walk/blend_position", input_direction);
		anim_tree.set("parameters/Turn/blend_position", input_direction);
		anim_tree.set("parameters/Sprint/blend_position", input_direction);
		
		if need_to_turn():
			player_state = Move_State.TURNING
			anim_state.travel("Turn")
		else:
			initial_position = position # in initial position punem pozitia actuala ca sa putem da la 
										#pozitia actuala pozitia in care vrem sa ajungem
			is_moving = true # obvious
			player_state = Move_State.WALKING
	else :
		anim_state.travel("Idle")
		player_state = Move_State.IDLE

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
	
func collect(item,n):
	inv.insert(item,n)
	pass
	
func lose(item, n):
	inv.substract(item,n)
	
func check(item):
	inv.exists(item)
