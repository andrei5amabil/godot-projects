extends Node2D

func _on_button_pressed() -> void:
	Global.is_elsewhere = true
	get_tree().call_deferred("change_scene_to_file","res://Scenes/main.tscn")
