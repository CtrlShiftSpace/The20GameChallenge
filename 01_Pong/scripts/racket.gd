extends StaticBody2D

# 第幾位玩家
@export var player_no: int = 1

@onready var collision_shape_2d = $CollisionShape2D

var _dist: float = 200.0
var _up_action: String
var _down_action: String
var _is_action_exist: bool = false
var _width: float
var _height: float
var _move_top_limit: float = 100.0
var _move_bottom_limit: float = 555.0

func _ready():
	_up_action = "player%d_up" % [player_no]
	_down_action = "player%d_down" % [player_no]
	# 確認接收動作是否存在
	if InputMap.has_action(_up_action) and InputMap.has_action(_down_action):
		_is_action_exist = true
	var size = collision_shape_2d.shape.get_rect().size
	_width = size[0]
	_height = size[1]

func _process(delta):
	if not _is_action_exist:
		return
	var way = 1
	# 向上移動
	if Input.is_action_pressed(_up_action):
		var movement = _dist * delta * -1
		if position.y + movement < _move_top_limit:
			position.y = _move_top_limit
		else:
			position.y += movement
	# 向下移動
	if Input.is_action_pressed(_down_action):
		var movement = _dist * delta
		if position.y + movement > _move_bottom_limit:
			position.y = _move_bottom_limit
		else:
			position.y += movement
