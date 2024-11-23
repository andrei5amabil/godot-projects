extends CharacterBody2D

const SPEED = 1.0

@export var path: Array = Array([],TYPE_VECTOR2,"",null)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var reached_destination: bool = true
var n: int 
var i: int = 0


func length() -> int:
	var nr = 0
	for j in path:
		nr = nr + 1
	return nr

func _ready() -> void:
	n = length()
	
func _physics_process(delta: float) -> void:
	
	
	if (position.x == path[i].x) and (position.y == path[i].y):
		if i<n-1:
			if path[i+1].x > path[i].x:
				animated_sprite_2d.play("right")
				animated_sprite_2d.flip_h = false
			elif path[i+1].x < path[i].x:
				animated_sprite_2d.play("right")
				animated_sprite_2d.flip_h = true
			if path[i+1].y > path[i].y:
				animated_sprite_2d.play("down")
			elif path[i+1].y < path[i].y:
				animated_sprite_2d.play("up")
			i=i+1
		else:
			if path[0].x > path[i].x:
				animated_sprite_2d.play("right")
				animated_sprite_2d.flip_h = false
			elif path[0].x < path[i].x:
				animated_sprite_2d.play("right")
				animated_sprite_2d.flip_h = true
			if path[0].y > path[i].y:
				animated_sprite_2d.play("down")
			elif path[0].y < path[i].y:
				animated_sprite_2d.play("up")
			i = 0

	position.x = move_toward(position.x, path[i].x, SPEED)
	position.y = move_toward(position.y, path[i].y, SPEED)
