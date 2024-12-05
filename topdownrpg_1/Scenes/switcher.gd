extends CanvasLayer

@onready var alex: Button = $ColorRect/Alex
@onready var andrei: Button = $ColorRect/Andrei
@onready var emi: Button = $ColorRect/Emi
@onready var julia: Button = $ColorRect/Julia

func _process(_delta):
	if Input.is_action_just_pressed("change_char"):
		visible = true

func _on_alex_pressed() -> void:
	if visible :
		Global.change_chat_leader(0)
		visible = false


func _on_andrei_pressed() -> void:
	if visible :
		Global.change_chat_leader(1)
		visible = false
	pass # Replace with function body.


func _on_emi_pressed() -> void:
	if visible :
		Global.change_chat_leader(2)
		visible = false
	pass # Replace with function body.


func _on_julia_pressed() -> void:
	if visible:
		Global.change_chat_leader(3)
		visible = false
	pass # Replace with function body.
