extends CharacterBody2D

# 第幾位玩家
@export var player_no: int = 1

var _velocity: Vector2 = Vector2(0, 50)
var _speed: float = 10.0
var _up_action: String
var _down_action: String
var _is_action_exist: bool = false
# 球是否在此檔板的上/下方
var _is_ball_top_border: bool = false
var _is_ball_bottom_border: bool = false

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
	var way = 1
	# 向上移動
	if Input.is_action_pressed(_up_action):
		velocity += _velocity * _speed * delta * -1
	# 向下移動
	if Input.is_action_pressed(_down_action):
		velocity += _velocity * _speed * delta
	move_and_collide(velocity)

func _on_top_area_body_entered(body):
	if body.is_in_group("ball"):
		_is_ball_top_border = true

func _on_top_area_body_exited(body):
	if body.is_in_group("ball"):
		_is_ball_top_border = false

func _on_bottom_area_body_entered(body):
	if body.is_in_group("ball"):
		_is_ball_bottom_border = true

func _on_bottom_area_body_exited(body):
	if body.is_in_group("ball"):
		_is_ball_bottom_border = false
