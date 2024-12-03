extends CharacterBody2D

@export var ordering : int 
@export var sprite_png : CompressedTexture2D = null
@export var player: CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var destination: Vector2 = player.position
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var anim_state = animation_tree.get("parameters/playback")

@onready var player_man = get_parent().get_node("Player")

signal stopped
signal moving
	
func _ready() -> void:
	animation_tree.active = true
	anim_state.travel("Idle")
	
	sprite_2d.texture = load( Global.chat[ordering+1] )
	
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
	
func _process(_delta):
	if player_man.player_state == player_man.Move_State.IDLE :
		
		anim_state.travel("Idle")
	if player_man.player_state == player_man.Move_State.WALKING :
		
		anim_state.travel("Walk")
	if player_man.player_state == player_man.Move_State.TURNING :
		
		anim_state.travel("Turn")
	
	if player_man.input_direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", player_man.input_direction);
		animation_tree.set("parameters/Walk/blend_position", player_man.input_direction);
		animation_tree.set("parameters/Turn/blend_position", player_man.input_direction);
		animation_tree.set("parameters/Sprint/blend_position", player_man.input_direction);
