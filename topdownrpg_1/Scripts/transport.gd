extends Area2D

@export var dest : String

@export var needs_confirmation : bool = true

@export var source : bool = false

@export var scale_modifier : float

@export var travel_location : Vector2

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var entered : bool
var player = null

func _process(_delta):
	if entered :
		if !needs_confirmation :
			get_tree().change_scene_to_file(dest)
		else :
			if Input.is_action_just_pressed("interact"):
				get_tree().change_scene_to_file(dest)
				Global.player_position_on_transition = travel_location

func _on_body_entered(body: CharacterBody2D) -> void:
	player = body
	entered = true


func _on_body_exited(_body: CharacterBody2D) -> void:
	entered = false
