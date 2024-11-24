extends CharacterBody2D

class_name Npc

var entered = false
var player = null

func _on_area_2d_body_entered(body: Player):
	entered = true
	player = body

func _on_area_2d_body_exited(body: Player):
	entered = false
