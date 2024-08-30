extends Node2D

@export var brick_scene: PackedScene

@onready var left_side: ColorRect = $Wall/LeftSide
@onready var right_side: ColorRect = $Wall/RightSide

var _start_position: Vector2 = Vector2.ZERO
# Brick到兩側的寬度
var _padding_width:float = 100.0
# 每列磚塊數量
var _brick_row_num = 9
# 每行磚塊數量
var _brick_col_num = 6

func _ready():
	var vp_size = get_viewport().size
	var vp_width = vp_size[0]
	var vp_height = vp_size[1]
	var aval_width = vp_width - left_side.get_rect().size[0] - right_side.get_rect().size[0]
	# 磚塊產生位置
	_start_position = Vector2(
						left_side.get_rect().size[0] + _padding_width, 
						100.0)

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
		
	
	
	
