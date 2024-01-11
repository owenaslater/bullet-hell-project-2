extends Enemy

func _ready():
	enemy_ready()
	pause_point = 1
	pause_time = 0.5
	health = 3
	path.add_point(Vector2(global_position.x-200,global_position.y),Vector2(50,50),Vector2(0,0))
	path.add_point(Vector2(global_position.x-300,global_position.y-600),Vector2.ZERO,Vector2.ZERO)
	check_curve()
	shoot_timer.set_wait_time(0.1)
	print("hello")
func _process(delta):
	enemy_process(delta)
	if (shooting && shoot_timer.is_stopped()):
		var direction = global_position.direction_to(GameController.player.global_position)
		shoot_timer.start()
		var b = bullet.instantiate()
		b.initiate(8,direction,"straight",get_position(),2)
		self.get_parent().add_child(b)
	
