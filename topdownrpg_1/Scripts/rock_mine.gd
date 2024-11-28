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
	if entered:
		if has_rocks:
			if Input.is_action_just_pressed("interact"):
				can_receive_ui = false
				ui_cd.start()
				player.collect(item,1)
				has_rocks = false
				rock_timer.start()
		else :
			if can_receive_ui && Input.is_action_just_pressed("interact"):
				can_receive_ui = false
				ui_cd.start()
				textbox.set_state_ready()
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
	can_receive_ui = true
