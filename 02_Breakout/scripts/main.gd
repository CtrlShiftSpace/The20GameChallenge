extends Node2D

@export var brick_scene: PackedScene

@onready var left_side: ColorRect = $Wall/LeftSide
@onready var right_side: ColorRect = $Wall/RightSide
@onready var score_label = $Hud/ScoreLabel
@onready var ball = $Ball
@onready var heart_grid = $Hud/HeartGrid

var _start_position: Vector2 = Vector2.ZERO
# Brick到兩側的寬度
var _padding_width: float = 100.0
# 每列磚塊數量
var _brick_row_num: int = 9
# 每行磚塊數量
var _brick_col_num: int = 6
# 生命值
var _lives: int = 3
# 分數
var _score: int = 0
# 生命
var _live_tr_list: Array
	
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
	
	#var live_img = Image.new()
	#live_img.load("res://assets/images/heart_icon.png")
	for i in _lives:
		var tr = TextureRect.new()
		tr.texture = load("res://assets/images/heart_icon.png")
		tr.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
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

# 更新分數	
func update_score():
	score_label.text = "Score: %s" % str(_score)

# 磚塊被破壞時的事件	
func on_brick_destroy():
	# 增加分數
	_score += 1
	update_score()
	
	
