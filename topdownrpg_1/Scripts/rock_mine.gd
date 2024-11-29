extends StaticBody2D

var has_rocks = true
@onready var rock_timer: Timer = $rock_timer
@onready var dialogue_timer: Timer = $Dialogue_timer

var entered = false
@onready var textbox: Textbox = $Textbox

@export var item : InvItem
@onready var ui_cd: Timer = $ui_cd

var player = null
var can_receive_ui = true

func _ready():
	pass

func _process(_delta):
	textbox.override_sm = true
	if entered:
		if Input.is_action_just_pressed("interact"):
			textbox.can_get_user_input = false
			ui_cd.start()
			if has_rocks:
				player.collect(item,1)
				has_rocks = false
				
				textbox.index = 0
				textbox.add_text()
				textbox.set_state_reading()
				
				rock_timer.start()
			else :
				textbox.index = 1
				textbox.add_text()
				textbox.set_state_reading()
	pass


func _on_rock_timer_timeout():
	if !has_rocks:
		has_rocks = true


func _on_area_2d_body_entered(body: Player):
	player = body
	print("entered rock mining area")
	if !entered:
		entered = true


func _on_area_2d_body_exited(body: Player) -> void:
	print("exited rock mining area")
	entered = false
	textbox.hide_text()
	textbox.set_state_idle()
	textbox.reset_index()
	pass # Replace with function body.


func _on_ui_cd_timeout() -> void:
	textbox.can_get_user_input = true
