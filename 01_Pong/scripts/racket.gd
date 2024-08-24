extends CharacterBody2D

# 第幾位玩家
@export var player_no: int = 1

var _velocity: Vector2 = Vector2(0, 100)
var _speed: float = 200.0
var _up_action: String
var _down_action: String
var _is_action_exist: bool = false

func _ready():
	_up_action = "player%d_up" % [player_no]
	_down_action = "player%d_down" % [player_no]
	# 確認接收動作是否存在
	if InputMap.has_action(_up_action) and InputMap.has_action(_down_action):
		_is_action_exist = true

func _physics_process(delta):
	velocity = Vector2.ZERO
	if not _is_action_exist:
		return
	# 向上移動
	if Input.is_action_pressed(_up_action):
		velocity += _velocity * _speed * delta * -1
	# 向下移動
	if Input.is_action_pressed(_down_action):
		velocity += _velocity * _speed * delta
	move_and_slide()

	
