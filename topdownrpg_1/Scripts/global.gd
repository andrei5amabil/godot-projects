extends Node

var player_position_on_transition = Vector2()

var is_elsewhere = false

func _ready():
	pass
	

var chat = { 0 : "res://Player_Res/Alex_Full.png", 1 : "res://Player_Res/Andrei_Full.png", 2 : "res://Player_Res/Emi_Full.png", 3 : "res://Player_Res/Julia_Full.png" }
var chat_order = {0 : 0, 1 : 1, 2 : 2, 3 : 3}
var player_key_to_position = {0:0, 1:1, 2:2, 3:3}

func change_chat_leader(x:int):
	var x_pos = player_key_to_position[x]
	var tmp = chat_order[0]
	chat_order[0] = x
	chat_order[x_pos] = tmp
	player_key_to_position[x] = 0
	player_key_to_position[0] = x
	pass
	
