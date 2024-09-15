extends Node2D

@export var brick_scene: PackedScene

@onready var left_side: ColorRect = $Wall/LeftSide
@onready var right_side: ColorRect = $Wall/RightSide
@onready var score_label = $Hud/ScoreLabel
@onready var paddle = $Paddle
@onready var ball = $Ball
@onready var heart_grid = $Hud/HeartGrid
@onready var ready_label = $Hud/HBCount/MCCount/ReadyLabel
@onready var game_over_label = $Hud/MCReminder/GameOverLabel
@onready var ready_timer = $ReadyTimer

var _start_position: Vector2 = Vector2.ZERO
# Brick到兩側的寬度
var _padding_width: float = 100.0
# 每列磚塊數量
var _brick_row_num: int = 9
# 每行磚塊數量
var _brick_col_num: int = 6
# 球初始的位置
var _ball_reset_position: Vector2 = Vector2(506, 510)
# 生命值
var _lives: int = 3
# 分數
var _score: int = 0
# 生命
var _live_tr_list: Array
# 是否結束遊戲
var _is_dead: bool = false
# 等待準備期間總次數
var _ready_total: int = 3
# 目前已經過的次數
var _ready_count: int = 0
	
func _ready():
	var vp_size = get_viewport().size
	var vp_width = vp_size[0]
	var vp_height = vp_size[1]
	var aval_width = vp_width - left_side.get_rect().size[0] - right_side.get_rect().size[0]
	# 磚塊產生位置
	_start_position = Vector2(
						left_side.get_rect().size[0] + _padding_width, 
						100.0)
	
	# 磚塊被破壞時的signal
	ball.on_brick_destroy.connect(on_brick_destroy)
	update_score()
	
	for i in _lives:
		var tr = TextureRect.new()
		tr.texture = load("res://assets/images/heart_icon.png")
		tr.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		tr.size_flags_vertical = Control.SIZE_EXPAND_FILL
		heart_grid.add_child(tr)
		_live_tr_list.append(tr)

	# 產生磚塊
	for i in range(_brick_row_num):
		for j in range(_brick_col_num):
			var new_brick = brick_scene.instantiate()
			var new_brick_width = new_brick.get_node("ColorRect").get_rect().size[0]
			var brick_position = Vector2(
									_start_position.x + i * (new_brick_width + 20),
									_start_position.y + j * 50
								)
			new_brick.position = brick_position 
			new_brick.scale = Vector2(0.8, 0.8)
			add_child(new_brick)
	
	restart_ready_timer()
		

# 更新分數	
func update_score():
	score_label.text = "Score: %s" % str(_score)
	
# 更新準備倒數剩餘秒數
func update_ready_remain():
	var ready_remain = _ready_total - _ready_count
	ready_label.text = str(ready_remain)

# 減少生命值
func decrease_lives(v: int):
	for i in range(v):
		var live_tr = _live_tr_list.pop_back()
		if live_tr == null:
			break
		# 移除生命圖示	
		live_tr.queue_free()
		# 檢查目前擁有的生命數量，小於等於0時則遊戲結束
		if _live_tr_list.size() <= 0:
			_is_dead = true
			break
			
# 重置等待發球的Timer	
func restart_ready_timer():
	_ready_count = 0
	# 畫面顯示剩餘秒數
	update_ready_remain()
	ready_label.visible = true
	# 倒數計時
	ready_timer.start()
	
func game_over():
	game_over_label.visible = true
	paddle._is_input_move = false

# 磚塊被破壞時的事件	
func on_brick_destroy():
	# 增加分數
	_score += 1
	update_score()
	
func _on_died_area_body_entered(body):
	# 如果球進入此區域
	if body.is_in_group("ball_group"):
		decrease_lives(1)
		body._is_stop = true
		if _is_dead:
			# 遊戲結束
			game_over()
			return
		# 重置球的位置與方向
		body.reset_direction()
		body.position = _ball_reset_position
		# 重置球的速度
		body.reset_speed()
		restart_ready_timer()

func _on_ready_timer_timeout():
	_ready_count += 1
	# 更新畫面上的剩餘秒數
	update_ready_remain()
	if _ready_count >= _ready_total:
		ball._is_stop = false
		ready_timer.stop()
		ready_label.visible = false
