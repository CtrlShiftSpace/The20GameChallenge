extends CharacterBody2D

var _velocity: Vector2 = Vector2(0, 100)
var _speed: float = 200.0

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += _velocity * _speed * delta * -1
	if Input.is_action_pressed("ui_down"):
		velocity += _velocity * _speed * delta
	move_and_slide()

	
