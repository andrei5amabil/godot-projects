extends CharacterBody2D

const SPEED = 1.0
const tile_size = 16
const TOL = 5

@export var path: Array = Array([],TYPE_VECTOR2,"",null)
@export var player: CharacterBody2D

@onready var waiting_to_move: Timer = $Waiting_to_move
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var chasing_time: Timer = $Chasing_time

var reached_destination: bool = true
var n: int 
var i: int = 0
var ready_to_move: bool = true
var is_chasing: bool = false
var setup_chase: bool = false
var chasing_vector: Vector2


func length() -> int:
	var nr = 0
	for j in path:
		nr = nr + 1
	return nr

func _ready() -> void:
	n = length()
	
func choose_side():    #0 este x, 1 este y
	if abs(position.x - player.position.x) > TOL:
		chasing_vector.x = player.position.x
		chasing_vector.y = position.y  
	else:
		chasing_vector.x = position.x
		chasing_vector.y = player.position.y
	
func chase():
	if not setup_chase:
		position.x = (int(position.x/tile_size)) * tile_size
		position.y = (int(position.y/tile_size)) * tile_size
		setup_chase = true
	if fmod(position.x,tile_size)==0 and fmod(position.y,tile_size) == 0:
		choose_side()
	move(chasing_vector)
	
	
func _physics_process(_delta: float) -> void:
	if ray_cast_2d.is_colliding():
		is_chasing = true
		chasing_time.start()
	if ready_to_move:
		if is_chasing:
			chase()
		else:
			if (position.x == path[i].x) and (position.y == path[i].y):
				if i<n-1:	
					i = i+1
				else:
					i = 0
			move(path[i])

func move(destination: Vector2):
	if ready_to_move:
		if fmod(position.x,tile_size)==0 and fmod(position.y,tile_size) == 0:
			ready_to_move = false
			waiting_to_move.start()
		
		if destination.x > position.x:
			animated_sprite_2d.play("right")
			animated_sprite_2d.flip_h = false
			ray_cast_2d.global_rotation = 0
		elif destination.x < position.x:
			animated_sprite_2d.play("right")
			animated_sprite_2d.flip_h = true
			ray_cast_2d.global_rotation = PI
		if destination.y > position.y:
			animated_sprite_2d.play("down")
			ray_cast_2d.global_rotation = PI/2
		elif destination.y < position.y:
			animated_sprite_2d.play("up")
			ray_cast_2d.global_rotation = (3*PI)/2

		position.x = move_toward(position.x, destination.x, SPEED)
		position.y = move_toward(position.y, destination.y, SPEED)


func _on_waiting_to_move_timeout() -> void:
	ready_to_move = true


func _on_chasing_time_timeout() -> void:
	is_chasing = false
	setup_chase = false
