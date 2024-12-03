extends Node

var player_position_on_transition = Vector2()

var is_elsewhere = false

func _ready():
	pass
	
var chat_order = [ 0,1,2,3 ]
var chat = [ "res://Player_Res/Alex_Full.png", "res://Player_Res/Andrei_Full.png", "res://Player_Res/Emi_Full.png", "res://Player_Res/Julia_Full.png" ]
var names = ["Alex" , "Andrei", "Emi", "Julia"]

func change_chat_leader(x:int):
	var tmp = chat[0]
	chat[0] = chat[x]
	chat[x] = tmp
	
	tmp = names[0]
	names[0] = names[x]
	names[x] = tmp
	
