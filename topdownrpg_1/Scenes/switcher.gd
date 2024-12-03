extends CanvasLayer

@onready var alex: Button = $ColorRect/Alex
@onready var andrei: Button = $ColorRect/Andrei
@onready var emi: Button = $ColorRect/Emi
@onready var julia: Button = $ColorRect/Julia



func _on_alex_pressed() -> void:
	Global.change_chat_leader(0)


func _on_andrei_pressed() -> void:
	Global.change_chat_leader(1)
	pass # Replace with function body.


func _on_emi_pressed() -> void:
	Global.change_chat_leader(2)
	pass # Replace with function body.


func _on_julia_pressed() -> void:
	Global.change_chat_leader(3)
	pass # Replace with function body.
