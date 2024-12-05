extends CharacterBody2D

# Speed of the NPC
@export var speed: float = 100.0
# Starting direction: -1 for left, 1 for right
@export var start_direction: int = 1

# Gravity force
@export var gravity: float = 800.0
# Current movement direction
var direction: int

# References to the child nodes
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

func _ready():
	# Set the starting direction
	direction = start_direction
	# Start playing the walking animation
	animated_sprite.play("walk")

func _physics_process(delta):
	# Apply gravity to vertical velocity
	velocity.y += gravity * delta

	# Set horizontal movement
	velocity.x = direction * speed

	# Move the NPC while handling collisions
	move_and_slide()

	# Flip sprite and collision polygon based on direction
	if direction > 0:
		animated_sprite.flip_h = true
		collision_polygon.scale.x = -1.0
	else:
		animated_sprite.flip_h = false
		collision_polygon.scale.x = 1.0

	# Check for walls or obstacles
	if is_on_wall():
		# Reverse direction if hitting a wall
		direction *= -1
