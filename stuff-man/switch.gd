extends StaticBody2D

@export var objects_to_toggle: Array[NodePath] = []

# Internal state
var is_activated: bool = false
@onready var anims: AnimatedSprite2D = $anims
@onready var collision_polygon: CollisionPolygon2D = $unpressedbody
# Called when the scene is ready
func _ready():
	# Set initial color of the switch
	anims.play("notpressed")

# Detect when a body enters the switch's area
func _on_body_entered(body):
	if not is_activated and body.is_in_group("player"):
		activate_switch()

# Activate the switch and toggle objects
func activate_switch():
	is_activated = true
	anims.play("pressing")
		
	# Toggle the state of connected objects
	for object_path in objects_to_toggle:
		var obj = get_node(object_path)
		if obj and obj.has_method("toggle"):
			obj.toggle()
