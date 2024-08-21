extends RigidBody2D

var _move_distance: float = 200.0

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y += _move_distance * -1 * delta
	if Input.is_action_pressed("ui_down"):
		position.y += _move_distance * delta
	
