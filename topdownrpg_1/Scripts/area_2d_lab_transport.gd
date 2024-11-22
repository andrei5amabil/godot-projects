extends Area2D

var entered = false

var player_position

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	if body.name == "Player":  # Ensure the body is the player
		player_position = body.position
		print("Player's position is:", player_position)

func _on_body_exited(_body: PhysicsBody2D) -> void:
	entered = false

func _process(_delta):
	if entered :
		if Input.is_action_just_pressed("interact"):
			Global.player_position_on_transition = player_position
			print(Global.player_position_on_transition )
			
			get_tree().change_scene_to_file("res://Scenes/lab.tscn")
