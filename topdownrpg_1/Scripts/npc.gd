extends CharacterBody2D

class_name Npc

var entered = false
var player = null

@export var item_wanted : InvItem
@export var item_given : InvItem

@onready var textbox: Textbox = $Textbox

	
func _process(_delta):
	if entered:
		if Input.is_action_just_pressed("interact"):
			textbox.set_state_ready()
			if player.inv.exists(item_wanted) > 1:
				print("check2")
				player.inv.substract(item_wanted, 2)
				player.inv.insert(item_given,1)
			else:
				print("hehehe")
	pass


func _on_area_2d_body_entered(body: Player):
	entered = true
	player = body
	
	
func _on_area_2d_body_exited(body: Player):
	entered = false
	textbox.hide_text()
	textbox.set_state_idle()
	textbox.reset_index()
