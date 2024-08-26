extends Node2D

# 測試用
@onready var ball = $Ball
var _speed = 20.0
var _angle = 0

func _ready():
	reset()

func reset():
	ball.position = Vector2(0, 166)
	print(_angle)
	ball.velocity = Vector2.RIGHT.rotated(deg_to_rad(_angle)) * _speed
	_angle -= 1

func _on_reset_area_body_entered(body):
	if body.is_in_group("ball"):
		reset()
