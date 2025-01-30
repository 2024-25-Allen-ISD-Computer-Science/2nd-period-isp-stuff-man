extends CharacterBody2D

# Variables
@export var speed: float = 800        # Movement speed
@export var jump_force: float = 800   # Jump strength
@export var gravity: float = 1600      # Gravity applied to the character
@export var animation_scene: PackedScene  # Assign your animation scene in the inspector
var jump_count: int = 1
var current_jumps: int = 0
var jumped_on_ground: bool = false

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
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()

		if collider.has_meta("enemy"):  # Replace 'Enemy' with your enemy class
			play_hit_animation(collision.get_position())
	# Handle jumping
	if is_on_floor():
		current_jumps = 0
		jumped_on_ground = false
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
		jumped_on_ground = true
	if Input.is_action_just_pressed("ui_up") and not is_on_floor() and jump_count > current_jumps:
		if jumped_on_ground == true:
			current_jumps = current_jumps + 1
		else:
			jumped_on_ground = true
		velocity.y = -jump_force
	# Move the character
	move_and_slide()

func play_hit_animation(position: Vector2):
	if animation_scene:
		var animation_instance = animation_scene.instantiate()
		get_parent().add_child(animation_instance)
		animation_instance.global_position = position
