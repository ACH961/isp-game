extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sounds: AudioStreamPlayer2D = $JumpSounds


var SPEED = 300.0
var JUMP_VELOCITY = -900.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation="JUMP"
	#add animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation="RUN"
	else:
		animated_sprite_2d.animation="IDLE"
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sounds.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction ==1.0:
		animated_sprite_2d.flip_h= false
	elif direction == -1.0:
		animated_sprite_2d.flip_h= true
