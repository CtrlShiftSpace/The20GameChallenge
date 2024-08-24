extends CharacterBody2D

# 接觸到檔板上下區塊時，觸發短暫timer
@onready var racket_border_timer = $RacketBorderTimer

var _speed: float = 10.0
var _racket_border_duration: float = 0.5
# 在接觸到racket時，是否要做處理
var _is_action_on_racket: bool = true

func _ready():
	randomize()
	velocity = Vector2(
					randi_range(5, 20),
					randi_range(5, 20)
				)
	racket_border_timer.wait_time = _racket_border_duration
				
func _physics_process(delta):
	# move_and_collide 依據傳入向量移動，當碰撞到物體時會回傳碰撞到的物件
	var collision_object = move_and_collide(velocity * _speed * delta)
	if collision_object:
		var collider = collision_object.get_collider()
		if collider.is_in_group("racket"):
			# 如果檢查目前接觸檔板時不需要做動作就return
			if not _is_action_on_racket:
				return
			print("touchw")
	
			# 當碰到檔板時，會改變x軸的移動方向
			velocity.x = -velocity.x
			# 如果碰到上方或下方，也要改變y軸的移動方向
			if collider._is_ball_top_border or collider._is_ball_bottom_border:
				velocity.y = -velocity.y
				# 接觸到就開始計時，這段時間內重複接觸到檔板也不會處理
				_is_action_on_racket = false
				print("_is_action_on_racket")
				racket_border_timer.start()
		else:
			# 當有碰撞到物件時，依照碰撞物體的法線，計算反彈的向量
			velocity = velocity.bounce(collision_object.get_normal())

	#print(velocity)

func _on_racket_border_timer_timeout():
	# 當時間到時，將接觸到racket改回需要處理狀態
	_is_action_on_racket = true
	print("timeout")
