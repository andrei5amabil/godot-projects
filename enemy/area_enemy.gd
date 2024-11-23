extends Area2D

func _on_body_entered(body: Node2D) -> void:
	Global.player_position_on_transition = body.position
	get_tree().call_deferred("change_scene_to_file","res://Scenes/fight_scene.tscn")
