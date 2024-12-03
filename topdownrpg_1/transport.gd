extends Area2D

@export var dest : String

@export var needs_confirmation : bool

@export var source : bool = false

@export var scale_modifier : float

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var entered : bool
var player = null

func _process(_delta):
	if entered :
		if source: 
			Global.player_position_on_transition = player.global_position
			Global.is_elsewhere = false
		else :
			Global.is_elsewhere = true
		if !needs_confirmation :
			
			get_tree().change_scene_to_file(dest)
		else :
			if Input.is_action_just_pressed("interact"):
				get_tree().change_scene_to_file(dest)

func _on_body_entered(body: CharacterBody2D) -> void:
	player = body
	entered = true


func _on_body_exited(_body: CharacterBody2D) -> void:
	entered = false
