extends CharacterBody2D

# Variables
@export var speed: float = 800        # Movement speed
@export var jump_force: float = 800   # Jump strength
@export var gravity: float = 1600      # Gravity applied to the character
var jump_count: int = 1
var current_jumps: int = 0

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
	if is_on_floor():
		current_jumps = 0
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
	if Input.is_action_just_pressed("ui_up") and not is_on_floor() and jump_count > current_jumps:
		current_jumps = current_jumps + 1
		velocity.y = -jump_force
	# Move the character
	move_and_slide()
