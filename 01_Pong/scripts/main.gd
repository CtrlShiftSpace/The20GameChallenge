extends Node2D

@onready 
var ball = $Ball
@onready 
var left_score_label = $UI/LeftScoreLabel
@onready 
var right_score_label = $UI/RightScoreLabel

var _init_ball_pos: Vector2 = Vector2(582, 300)
# 初始化移動向量
var _ball_vector: Vector2 = Vector2(500, 100)
var _is_touch_left: bool = false
var _is_touch_right: bool = false
var _is_score_count: bool = false
var _left_score: int = 0
var _right_score: int = 0

func _ready():
	ball.position = _init_ball_pos
	ball.on_first_racket_touch.connect(ball_first_touch_racket)
	update_ui_score()
	
func _physics_process(delta):
	if _is_touch_left or _is_touch_right:
		_is_touch_left = false
		_is_touch_right = false
		
# 更新畫面的分數
func update_ui_score():
	left_score_label.text = str(_left_score)
	right_score_label.text = str(_right_score)
	
# 第一次碰到擋版
func ball_first_touch_racket():
	# 當碰到擋版後才開始計分
	_is_score_count = true
	
func _on_over_area_l_body_entered(body):
	if body.is_in_group("Ball"):
		_is_touch_left = true

func _on_over_area_r_body_entered(body):
	if body.is_in_group("Ball"):
		_is_touch_right = true

func _on_score_area_l_body_entered(body):
	if _is_score_count and body.is_in_group("Ball"):
		_right_score += 1
		update_ui_score()

func _on_score_area_r_body_entered(body):
	if _is_score_count and body.is_in_group("Ball"):
		_left_score += 1
		update_ui_score()
