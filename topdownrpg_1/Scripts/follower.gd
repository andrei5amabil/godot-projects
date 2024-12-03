extends CharacterBody2D

@export var selection : int = 0
@export var player: CharacterBody2D

@onready var destination: Vector2 = player.position
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var try = false

@onready var player_man = get_parent().get_node("Player")

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
	
	if try :
		trying()
	else :
		
		if player_man.player_state == player_man.Move_State.WALKING :
			if selection == 0 :
				
				
					if destination.x > position.x:
						animated_sprite_2d.play("julia_right")
						animated_sprite_2d.flip_h = false
						z_index = 1
							
					elif destination.x < position.x:
						animated_sprite_2d.play("julia_right")
						animated_sprite_2d.flip_h = true
						z_index = 1
						
					if destination.y > position.y:
						animated_sprite_2d.play("julia_down")
						z_index = 1
						
					elif destination.y < position.y:
						animated_sprite_2d.play("julia_up")
						z_index = 3
			
			elif selection == 1 :
				
				
					
					if destination.x > position.x:
						animated_sprite_2d.play("andrei_right")
						animated_sprite_2d.flip_h = false
						z_index = 1
							
					elif destination.x < position.x:
						animated_sprite_2d.play("andrei_right")
						animated_sprite_2d.flip_h = true
						z_index = 1
						
					if destination.y > position.y:
						animated_sprite_2d.play("andrei_down")
						z_index = 1
						
					elif destination.y < position.y:
						animated_sprite_2d.play("andrei_up")
						z_index = 3
						
			if selection == 2 :
				
				
					
					if destination.x > position.x:
						animated_sprite_2d.play("emi_right")
						animated_sprite_2d.flip_h = false
						z_index = 1
							
					elif destination.x < position.x:
						animated_sprite_2d.play("emi_right")
						animated_sprite_2d.flip_h = true
						z_index = 1
						
					if destination.y > position.y:
						animated_sprite_2d.play("emi_down")
						z_index = 1
						
					elif destination.y < position.y:
						animated_sprite_2d.play("emi_up")
						z_index = 3
						
						
			if selection == 3 :
				
				
					
					if destination.x > position.x:
						animated_sprite_2d.play("alex_right")
						animated_sprite_2d.flip_h = false
						z_index = 1
							
					elif destination.x < position.x:
						animated_sprite_2d.play("alex_right")
						animated_sprite_2d.flip_h = true
						z_index = 1
						
					if destination.y > position.y:
						animated_sprite_2d.play("alex_down")
						z_index = 1
						
					elif destination.y < position.y:
						animated_sprite_2d.play("alex_up")
						z_index = 3
		else :
			if selection == 0 :
				animated_sprite_2d.play("j_idle")
			
			elif selection == 1 :
				animated_sprite_2d.play("a_idle")
						
			if selection == 2 :
				animated_sprite_2d.play("e_idle")
						
			if selection == 3 :
				animated_sprite_2d.play("alex_idle")

func trying():
	pass
