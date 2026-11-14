extends CharacterBody2D
 
const SPEED = 200.0 
const JUMP_VELOCITY = -450.0 
 
@onready var anim = $AnimatedSprite2D 
 
func _physics_process(delta): 
	# Gravedad 
	if not is_on_floor(): 
		velocity += get_gravity() * delta 
 
	# Salto 
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
 
	# Movimiento 
	var direction := Input.get_axis("ui_left", "ui_right") 
	velocity.x = direction * SPEED 
 
	# Animaciones 
	if not is_on_floor(): 
		# En el aire: siempre mostrar piernas cerradas 
		anim.play("jump") 
 
	elif direction != 0: 
		# Caminando: reproducir los dos frames 
		anim.play("default") 
 
		# Girar hacia donde camina 
		if direction > 0: 
			anim.flip_h = false 
		else: 
			anim.flip_h = true 
 
	else: 
		# Quieto: piernas cerradas 
		anim.play("idle")
		anim.frame != 0
		
	move_and_slide()
