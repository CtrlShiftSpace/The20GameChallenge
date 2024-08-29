extends CharacterBody2D

# 移動方向
var _direction: Vector2 = Vector2.ZERO
# 移動速度
var _speed: float = 300.0

func _ready():
	randomize()
	_direction = Vector2(0.5, 0.5)
	
func _physics_process(delta):
	var coll_object: KinematicCollision2D = move_and_collide(_direction * _speed * delta)
	if coll_object:
		_direction = _direction.bounce(coll_object.get_normal())
		var collider = coll_object.get_collider()
		# 撞到擋板
		if collider.is_in_group("paddle_group"):
			# 增加速度
			_speed += 20
