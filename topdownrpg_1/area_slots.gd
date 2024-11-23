extends Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var timer: Timer = $"../Timer"
@onready var animation_tree: AnimationTree = $"../AnimationTree"

@onready var anim_state = animation_tree.get("parameters/playback")

enum state_machine {IDLE, GAMBLE, JACKPOT, MEDWIN, LOSER}
var gambler_state = state_machine.JACKPOT
var is_already_running = false

var entered = false
var gamble_state
# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
var g1
var g2
var g3
func _ready():
	animation_tree.active = true
	anim_state.travel("Idle")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if entered :
		if Input.is_action_just_pressed("interact") && !is_already_running:
			is_already_running = true
			audio_stream_player_2d.play()
			anim_state.travel("Gamble")
			timer.start()
			
			


func _on_body_entered(body: Node2D) -> void:
	entered = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	entered = false
	pass # Replace with function body.


func _on_timer_timeout():
	g1 = rng.randi() % 10
	g2 = rng.randi()%10
	g3 = rng.randi()%10
	if g1 == g2 || g2 == g3 || g1 == g3:
		if g1 == 7 || g2 == 7:
			print("Big Win")
			anim_state.travel("MedWin")
		elif g1 <= 5 || g2 >= 5:
			print("Medium Win")
			anim_state.travel("MedWin")
		elif (g1 + g2 + g3) / 3 > 5:
			print("Small Win")
			anim_state.travel("MedWin")
		
		elif g1 == g2 && g2 == g3:
			if g1 == 7:
				print("JACKPOT")
				anim_state.travel("Jackpot")
			if g1 == 3:
				print("Small Win")
				anim_state.travel("Jackpot")
	else:
		print("Loser")
		anim_state.travel("Loser")
	is_already_running = false
