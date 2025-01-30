extends Control

@onready var anim = $bamanim

func _ready():
	anim.play("default")  # Replace with your animation name
	anim.animation_finished.connect(queue_free)
