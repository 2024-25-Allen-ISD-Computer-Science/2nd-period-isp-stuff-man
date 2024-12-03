extends CharacterBody2D

# Variables
@export var speed: float = 400        # Movement speed
@export var jump_force: float = 400   # Jump strength
@export var gravity: float = 800      # Gravity applied to the character

func _physics_process(delta: float):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle horizontal movement
	var input_direction = 0
	if Input.is_action_pressed("ui_left"):
		input_direction -= 1
	if Input.is_action_pressed("ui_right"):
		input_direction += 1
	velocity.x = input_direction * speed

	# Handle jumping
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force

	# Move the character
	move_and_slide()
