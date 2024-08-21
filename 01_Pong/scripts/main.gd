extends Node2D

@onready var ball = $Ball

# 初始化移動向量
var _ball_vector: Vector2 = Vector2(500, 100)

func _ready():
	ball.linear_velocity = _ball_vector
	
func _physics_process(delta):
	print(ball.linear_velocity)
	pass
	
