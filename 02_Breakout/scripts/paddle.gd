extends StaticBody2D

var _move_distance: float = 400.0

func _process(delta):
	# 向左移動
	if Input.is_action_pressed("ui_left"):
		position.x += _move_distance * -1 * delta
	# 向右移動
	elif  Input.is_action_pressed("ui_right"):
		position.x += _move_distance * delta
