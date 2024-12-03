extends CharacterBody2D

class_name Npc

var entered = false
var player = null

var is_in_dialogue = false

@export var item_wanted : InvItem
@export var item_given : InvItem

@onready var textbox: Textbox = $Textbox

@onready var ui_cd: Timer = $ui_cd

	
func _process(_delta):
	textbox.override_sm = true
	if entered:
		if is_in_dialogue:
			if Input.is_action_just_pressed("interact"):
				textbox.can_get_user_input = false
				ui_cd.start()
				if textbox.index != 3:
					textbox.set_state_ready()
				else:
					if (player.inv.exists(item_wanted) > 1):
						textbox.index = 3
						textbox.add_text()
						textbox.set_state_reading()
						player.inv.substract(item_wanted, 2)
						player.inv.insert(item_given,1)
						if (player.inv.exists(item_wanted) > 1):
							textbox.index = 2
						else:
							textbox.index += 1
					else :
						textbox.index += 1
						textbox.set_state_ready()
		else :
			if Input.is_action_just_pressed("interact"):
				textbox.set_state_ready()
				is_in_dialogue = true
	pass


func _on_area_2d_body_entered(body: Player):
	entered = true
	player = body
	
	
func _on_area_2d_body_exited(body: Player):
	entered = false
	is_in_dialogue = false
	textbox.hide_text()
	textbox.set_state_idle()
	textbox.reset_index()



func _on_ui_cd_timeout() -> void:
	textbox.can_get_user_input = true
