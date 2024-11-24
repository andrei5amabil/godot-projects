extends CharacterBody2D

class_name Npc

var entered = false
var player = null

@export var item_wanted : InvItem
@export var item_given : InvItem


	
func _process(_delta):
	if entered:
		if Input.is_action_just_pressed("interact"):
			if player.inv.exists(item_wanted) > 1:
				print("check2")
				player.inv.substract(item_wanted, 2)
				player.inv.insert(item_given)
			else:
				print("hehehe")
	pass


func _on_area_2d_body_entered(body: Player):
	entered = true
	player = body
	print("cf papuse")


func _on_area_2d_body_exited(body: Player):
	entered = false
	print("pa papuse")
