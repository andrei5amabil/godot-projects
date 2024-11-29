class_name Textbox extends CanvasLayer

@onready var textbox_container: MarginContainer = $TextboxContainer
@onready var start: Label = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end: Label = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var message: Label = $TextboxContainer/MarginContainer/HBoxContainer/Message

var can_get_user_input = true

var override_sm = false

var next_text

enum State {IDLE, READY, READING, DONE }
var current_state = State.IDLE

var tween

#add text queue
@export var text_queue : Array

var text_copy : Array
var index : int
var size : int


func queue_text(i : int):
	next_text = text_queue[i]

func _ready():
	print("starting state : Ready")
	hide_text()
	index = 0
	message.visible_ratio = 0.0
	print(text_queue.size())
	pass

func _process(_delta):
	if !override_sm:
		match current_state:
			State.IDLE:
				if can_get_user_input:
					pass
				pass
			State.READY:
				if index < text_queue.size():
					add_text()
				else:
					hide_text()
					index = 0
					change_state(State.IDLE)
				pass
			State.READING:
				if can_get_user_input:
					if Input.is_action_just_pressed("interact"):
						tween.kill()
						message.visible_ratio = 1.0
						end.text = "v"
						change_state(State.DONE)
				pass
			State.DONE:
				if can_get_user_input:
					if Input.is_action_just_pressed("interact"):
						change_state(State.READY)
				pass
	else:
		custom_sm()



func custom_sm():
	match current_state:
			State.IDLE:
				hide_text()
				index = 0
				set_state_idle()
				pass
			State.READY:
				if index < text_queue.size():
					add_text()
				else:
					hide_text()
					index = 0
					set_state_idle()
				pass
			State.READING:
				if can_get_user_input && Input.is_action_just_pressed("interact"):
					tween.kill()
					message.visible_ratio = 1.0
					end.text = "v"
					set_state_done()
				pass
			State.DONE:
				if can_get_user_input && Input.is_action_just_pressed("interact"):
					set_state_idle()
				pass

func hide_text():
	start.text = ""
	end.text = ""
	message.text = ""
	textbox_container.hide()
	pass

func show_text():
	start.text = "*"
	textbox_container.show()
	
func add_text():
	queue_text(index)
	index += 1
	message.text = next_text
	set_state_reading()
	message.visible_ratio = 0.0
	show_text()
	tween = create_tween()
	tween.tween_property(message, "visible_ratio", 1.0, ( 0.01 * next_text.length() ) )
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	set_state_done()
	end.text = "v"

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("state is now ready")
			pass
		State.READING:
			print("state is now reading")
			pass
		State.DONE:
			print("state is now done")
			pass

func set_state_ready():
	current_state = State.READY
	
func set_state_idle():
	current_state = State.IDLE

func set_state_reading():
	current_state = State.READING
	
func set_state_done():
	current_state = State.DONE

func reset_index():
	index = 0
