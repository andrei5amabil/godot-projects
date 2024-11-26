extends CharacterBody2D

@export var player: CharacterBody2D

@onready var destination: Vector2 = player.position
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal stopped
signal moving
	
func _ready() -> void:
	player.stopped.connect(on_destination_stopped)
	player.moving.connect(on_destination_moving)
	position = destination
	
	
func on_destination_stopped(destination_pos: Vector2):
	stopped.emit(position)
	destination = destination_pos


func on_destination_moving(speed):
	moving.emit(speed)
	position.x = move_toward(position.x, destination.x, speed)
	position.y = move_toward(position.y, destination.y, speed)

	
		
		
func _process(delta: float) -> void:
	if destination.x > position.x:
		animated_sprite_2d.play("right")
		animated_sprite_2d.flip_h = false
		z_index = 1
			
	elif destination.x < position.x:
		animated_sprite_2d.play("right")
		animated_sprite_2d.flip_h = true
		z_index = 1
		
	if destination.y > position.y:
		animated_sprite_2d.play("down")
		z_index = 1
		
	elif destination.y < position.y:
		animated_sprite_2d.play("up")
		z_index = 3
		
