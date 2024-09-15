extends StaticBody2D

@onready var sprite_2d = $Sprite2D

var _move_distance: float = 400.0
var _min_x: float = 40.0
var _max_x: float = 1112.0
var _width: float = 0.0
# 是否可以透過輸入移動
var _is_input_move: bool = true

func _ready():
	# 檔板寬度
	_width = sprite_2d.get_rect().size[0]

func _process(delta):
	if not _is_input_move:
		return
		
	var is_move = false
	# 向左移動
	if Input.is_action_pressed("ui_left"):
		is_move = true
		position.x = get_x_axis_in_range(position.x + _move_distance * -1 * delta)
	# 向右移動
	elif  Input.is_action_pressed("ui_right"):
		is_move = true
		position.x = get_x_axis_in_range(position.x + _move_distance * delta)
		
# 取得限制範圍的X座標
func get_x_axis_in_range(x):
	var half_width = _width
	return clampf(x, _min_x + half_width, _max_x - half_width)
