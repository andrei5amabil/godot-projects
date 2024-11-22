extends Area2D

var entered = false
# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
var g1
var g2
var g3
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered :
		if Input.is_action_just_pressed("interact"):
			g1 = rng.randi() % 10
			g2 = rng.randi()%10
			g3 = rng.randi()%10
			if g1 == g2 || g2 == g3 || g1 == g3:
				if g1 == 7 || g2 == 7:
					print("Big Win")
				elif g1 <= 5 || g2 >= 5:
					print("Medium Win")
				elif (g1 + g2 + g3) / 3 > 5:
					print("Small Win")
			elif g1 == g2 && g2 == g3:
				if g1 == 7:
					print("JACKPOT")
				if g1 == 3:
					print("Small Win")
			else:
				print("Loser")
	pass


func _on_body_entered(body: Node2D) -> void:
	entered = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	entered = false
	pass # Replace with function body.
