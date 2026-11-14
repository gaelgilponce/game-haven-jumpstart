extends CharacterBody2D

var speed = 200
var jump_force = -400
var gravity = 900

enum State { IDLE, JUMP, FALL, LEFT, RIGHT }
var current_state = State.IDLE

func _physics_process(delta):
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movimiento horizontal
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		current_state = State.RIGHT
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		current_state = State.LEFT
	else:
		velocity.x = 0

	# Saltar con flecha arriba
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
		current_state = State.JUMP
	elif not is_on_floor() and velocity.y > 0:
		current_state = State.FALL
	elif is_on_floor() and velocity.x == 0:
		current_state = State.IDLE

	move_and_slide()

	# Debug: mostrar estado actual
	match current_state:
		State.IDLE:
			print("Idle")
		State.JUMP:
			print("Jump")
		State.FALL:
			print("Fall")
		State.LEFT:
			print("Left")
		State.RIGHT:
			print("Right")
