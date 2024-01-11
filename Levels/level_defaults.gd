extends Node2D

class_name LevelDefaults

var screen_width = ProjectSettings.get("display/window/size/viewport_width")
var screen_height = ProjectSettings.get("display/window/size/viewport_height")


#Params left to right, enemy scene name to spawn, initial spawn position, direction of movement (up or down), number of enemies to spawn, the direction that they're spaced out
func spawn_enemy(enemy_name,pos,dir,number,spawnspacing):
	var gap = Vector2(0,0)
	if(number>1):
		#setting the space between each spawned enemy
		match spawnspacing:
			"up":
				gap = Vector2(0,-30)
			"upright":
				gap = Vector2(15,-15)
			"right":
				gap = Vector2(30,0)
			"downright":
				gap = Vector2(15,15)
			"down":
				gap = Vector2(0,30)
			"downleft":
				gap = Vector2(-15,15)
			"left":
				gap = Vector2(-30,0)
			"upleft":
				gap = Vector2(-15,-15)
			_:
				gap = Vector2(30,0)
	var spawnpos = Vector2(screen_width+30,screen_height*pos)
	#spawns each of the enemies
	for x in number:
		var enemy = load("res://Enemy/%s.tscn" % enemy_name).instantiate()
		enemy.global_position = spawnpos
		spawnpos+=gap*2
		#inverts the curve on the Y axis, see enemy check_curve() function
		match dir:
			"up":
				enemy.flip_y = false
			"down":
				enemy.flip_y = true
		get_tree().get_root().add_child(enemy)
		#time between each enemy spawn
		await get_tree().create_timer(1).timeout
	


