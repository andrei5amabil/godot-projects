extends Node

var player_position_on_transition = Vector2()

var is_elsewhere = false

func _ready():
	pass
	
var chat_order = [ 0,1,2,3 ]
var chat = { 0 : "res://Player_Res/Alex_Full.png", 1 : "res://Player_Res/Andrei_Full.png", 2 : "res://Player_Res/Emi_Full.png", 3 : "res://Player_Res/Julia_Full.png" }
var names = {0 : 0, 1 : 1, 2 : 2, 3 : 3}

func change_chat_leader(x:int):
	if x != 0 :
	
		var tmp = chat[0]
		chat[0] = chat[x]
		chat[x] = tmp
		
		tmp = names[0]
		names[0] = names[x]
		names[x] = tmp
	
	else :
		
		pass
	
