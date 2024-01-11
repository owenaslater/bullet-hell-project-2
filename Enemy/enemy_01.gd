extends Enemy

func _ready():
	enemy_ready()
	pause_point = 1
	pause_time = 8
	path.add_point(Vector2(global_position.x-200,global_position.y),Vector2(50,50),Vector2(-50,-50))
	path.add_point(Vector2(global_position.x-300,global_position.y-200),Vector2.ZERO,Vector2.ZERO)
	path.add_point(Vector2(global_position.x-300,global_position.y-600),Vector2.ZERO,Vector2.ZERO)
	check_curve()
	shoot_timer.wait_time = 1

func _process(delta):
	enemy_process(delta)
	if (shooting && shoot_timer.is_stopped()):
		var direction = global_position.direction_to(GameController.player.global_position)
		shoot_timer.start()
		var b = bullet.instantiate()
		var b2 = bullet.instantiate()
		var b3 = bullet.instantiate()
		b.initiate(8,direction,"slowing",get_position(),2)
		b2.initiate(8,direction.rotated(0.17),"slowing",get_position(),2)
		b3.initiate(8,direction.rotated(-0.17),"slowing",get_position(),2)
		self.get_parent().add_child(b)
		self.get_parent().add_child(b2)
		self.get_parent().add_child(b3)
	
