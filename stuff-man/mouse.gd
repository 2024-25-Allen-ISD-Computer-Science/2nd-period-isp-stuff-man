extends CharacterBody2D

# Speed of the NPC
@export var speed: float = 100.0
# Starting direction: -1 for left, 1 for right
@export var start_direction: int = 1

# Gravity force
@export var gravity: float = 800.0
# Current movement direction
var direction: int
var frame: int = 0
# References to the child nodes
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D0

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
	if frame < 3:
		frame = frame + 1
	else:
		frame = 0
	if frame == 0:
		collision_polygon = $CollisionPolygon2D0
	elif frame == 1:
		collision_polygon = $CollisionPolygon2D1
	elif frame == 2:
		collision_polygon = $CollisionPolygon2D2
	elif frame == 3:
		collision_polygon = $CollisionPolygon2D3

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
