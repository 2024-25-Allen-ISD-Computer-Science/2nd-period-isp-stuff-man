extends StaticBody2D

@export var objects_to_toggle: Array[NodePath] = []

# Internal state
var is_activated: bool = false

# Called when the scene is ready
func _ready():
	# Set initial color of the switch
	if $anims:
		$anims.play("notpressed")

# Detect when a body enters the switch's area
func _on_body_entered(body):
	if not is_activated and body.is_in_group("player"):
		activate_switch()

# Activate the switch and toggle objects
func activate_switch():
	is_activated = true

	# Change the switch's appearance
	if $anims:
		$anims.play("pressing")
		

	# Toggle the state of connected objects
	for object_path in objects_to_toggle:
		var obj = get_node(object_path)
		if obj and obj.has_method("toggle"):
			obj.toggle()
