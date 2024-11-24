extends StaticBody2D

var has_rocks = true
@onready var timer: Timer = $Timer
var entered = false

@export var item : InvItem

var player = null

func _ready():
	pass

func _process(_delta):
	if entered:
		if has_rocks:
			if Input.is_action_just_pressed("interact"):
				player.collect(item,1)
				has_rocks = false
				timer.start()
	pass


func _on_timer_timeout():
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
	pass # Replace with function body.
