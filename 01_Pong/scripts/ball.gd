extends CharacterBody2D

var _speed: float = 200.0

func _ready():
	randomize()
	velocity = Vector2(
					randf_range(0.5, 2.0),
					randf_range(0.5, 2.0)
				)
				
func _physics_process(delta):
	# move_and_collide 依據傳入向量移動，當碰撞到物體時會回傳碰撞到的物件
	var collision_object = move_and_collide(velocity * _speed * delta)
	if collision_object:
		# 當有碰撞到物件時，依照碰撞物體的法線，計算反彈的向量
		velocity = velocity.bounce(collision_object.get_normal())
