class_name Vendor extends Area2D

@export var size = scale
@onready var textbox: Textbox = $Textbox
@onready var ui_cd: Timer = $ui_cd

@export var item_wanted : InvItem
@export var item_given : InvItem

var entered = false

var player = null

func _on_body_entered(body: CharacterBody2D) -> void:
	entered = true
	player = body

func _on_body_exited(body: CharacterBody2D) -> void:
	entered = false
	textbox.hide_text()
	textbox.set_state_idle()
	textbox.reset_index()

func _process(_delta):
	textbox.override_sm = true
	if entered:
		if Input.is_action_just_pressed("interact"):
			textbox.visible = true
			textbox.can_get_user_input = false
			ui_cd.start()
			textbox.set_state_ready()
			if Input.is_action_just_pressed("interact") && textbox.index == 1:
				if (player.inv.exists(item_wanted) > -1):
					player.inv.substract(item_wanted,0)
					player.inv.insert(item_given,1)
				textbox.set_state_ready()
			
	pass


func _on_ui_cd_timeout() -> void:
	textbox.can_get_user_input = true
