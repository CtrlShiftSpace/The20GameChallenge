extends CharacterBody2D

signal on_brick_destroy

# 移動方向
var _direction: Vector2 = Vector2.ZERO
# 移動速度
var _speed: float = 300.0
# 是否停止行動
var _is_stop: bool = true

func _ready():
	randomize()
	reset_direction()
	
# 重置移動方向
func reset_direction():
	_direction = Vector2(0.5, 0.5)
	
# 重置移動速度	
func reset_speed():
	_speed = 300.0
	
func _physics_process(delta):
	# 如果狀態為停止行動，則不做任何處理
	if _is_stop:
		return
	var coll_object: KinematicCollision2D = move_and_collide(_direction * _speed * delta)
	if coll_object:
		_direction = _direction.bounce(coll_object.get_normal())
		var collider = coll_object.get_collider()
		# 碰到磚塊
		if collider.is_in_group("brick_group"):
			_speed += 20
			collider.queue_free()
			on_brick_destroy.emit()
	
