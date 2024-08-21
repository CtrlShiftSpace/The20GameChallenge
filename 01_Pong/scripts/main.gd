extends Node2D

@onready var ball = $Ball

var _init_ball_pos: Vector2 = Vector2(582, 300)
# 初始化移動向量
var _ball_vector: Vector2 = Vector2(500, 100)
var _is_touch_left: bool = false
var _is_touch_right: bool = false

func _ready():
	ball.position = _init_ball_pos
	
func _physics_process(delta):
	if _is_touch_left or _is_touch_right:
		_is_touch_left = false
		_is_touch_right = false
	
func _on_over_area_l_body_entered(body):
	if body.is_in_group("Ball"):
		_is_touch_left = true

func _on_over_area_r_body_entered(body):
	if body.is_in_group("Ball"):
		_is_touch_right = true
