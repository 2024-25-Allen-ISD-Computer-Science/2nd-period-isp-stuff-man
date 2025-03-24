extends CharacterBody2D

# Speed of the NPC
@export var speed: float = 100.0
@export var bounciness: float = 2.0
# Starting direction: -1 for left, 1 for right
@export var start_direction: int = 1
@export var max_hp: int = 3
var current_hp: int
# Gravity force
@export var gravity: float = 800.0
@export var invincibility_time: float = 0.5  # Time (in seconds) enemy is invincible after getting hit
# Current movement direction
var direction: int
var is_invincible: bool = false
# References to the child nodes
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

func _ready():
	# Set the starting direction
	direction = start_direction
	# Start playing the walking animation
	animated_sprite.play("walk")
	current_hp = max_hp
	
func take_damage(amount: int):
	if is_invincible:
		return  # Ignore damage if in invincible state

	current_hp -= amount
	print("Enemy HP:", current_hp)

	if current_hp <= 0:
		die()
	else:
		start_invincibility()

func start_invincibility():
	is_invincible = true
	var tween = get_tree().create_tween()
	animated_sprite.play("hurt")
	# Flash effect: Blink between red and normal color
	for i in range(3):
		tween.tween_property(self, "modulate", Color(1, 0.5, 0.5), 0.1)  # Flash red
		tween.tween_property(self, "modulate", Color(1, 1, 1), 0.1)  # Back to normal
	
	await get_tree().create_timer(invincibility_time).timeout
	animated_sprite.play("walk")
	is_invincible = false  # End invincibility

func die():
	queue_free()  # Replace with death animation if needed


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
