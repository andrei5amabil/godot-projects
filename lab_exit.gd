extends Area2D

var entered = false

func _on_body_entered(body: Player):
	entered = true

func _on_body_exited(body: Player) -> void:
	entered = false

func _process(delta):
	if entered :
		if Input.is_action_just_pressed("interact"):
			Global.is_elsewhere = true
			get_tree().change_scene_to_file("res://main.tscn")
