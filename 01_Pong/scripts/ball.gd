extends CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var start_timer = $StartTimer

# 移動方向
var _direction: Vector2 = Vector2.ZERO
var _speed: float = 500.0
# 在接觸到racket時，是否要做處理
var _is_action_on_racket: bool = true

func _ready():
	randomize()
	reset()
				
func _physics_process(delta):
	# move_and_collide 依據傳入向量移動，當碰撞到物體時會回傳碰撞到的物件
	var collision_object = move_and_collide(_direction * _speed * delta)
	if collision_object:
		var collider = collision_object.get_collider()
		if collider.is_in_group("racket"):
			# 如果檢查目前接觸檔板時不需要做動作就return
			#if not _is_action_on_racket:
				#return
	
			# 當碰到檔板時，會改變x軸的移動方向
			_direction.x = -_direction.x
			# 碰撞的座標
			var colli_pos = collision_object.get_position()
			var colld_pos = collider.global_position
			#print("碰撞到的座標: ", colli_pos)
			#print("物體的座標: ", colld_pos)
			#print("pos: ", position)
			#print("col: ", colld_pos)
			#print("_width :", collider._width)
			#print("_height :", collider._height)
			
			var min_x = colld_pos.x - collider._width / 2 - collision_shape_2d.shape.radius
			var max_x = colld_pos.x + collider._width / 2 + collision_shape_2d.shape.radius
			var min_y = colld_pos.y - collider._height / 2
			var max_y = colld_pos.y + collider._height / 2
			
			# 如果是碰到上方或下方，也要改變y軸的移動方向
			if position.x >= min_x and position.x <= max_x \
				and (position.y <= min_y or position.y >= max_y) :
				_direction.y = -_direction.y
		else:
			# 當有碰撞到物件時，依照碰撞物體的法線，計算反彈的向量
			_direction = _direction.bounce(collision_object.get_normal())

func reset():
	_direction = Vector2.ZERO
	position = Vector2(579, 342)
	start_timer.start()

func _on_start_timer_timeout():
	_direction = Vector2(randf(), randf()).normalized()
