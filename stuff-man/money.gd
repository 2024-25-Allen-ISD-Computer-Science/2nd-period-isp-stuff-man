extends StaticBody2D

@export var value: float = 0.01
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
		
func get_cash():
	print("got $" + str(value))
	Globalvars.money += value
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
