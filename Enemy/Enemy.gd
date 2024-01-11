extends CharacterBody2D

class_name Enemy

##To add 
##A way for enemie to set the bullet speed
@onready var bullet = preload("res://Projectiles/bullet.tscn")
var health = 10
#The value scored when killing this enemy
var point_value = 200
#Movement speed
var speed = 300
#Hitbox of the enemy
var area:Area2D
#path the enemy takes
var path:Curve2D = Curve2D.new()
#timer to space out bullets
var shoot_timer = Timer.new()

var flip_y:bool = false
var shooting = false
var pause_point:int
var pause_time:float
var t = 0
var delta_weight = 1
enum states{MOVINGIN, STOPPED, MOVINGOUT}
var state = states.MOVINGIN

func enemy_ready():
	path.add_point(global_position,Vector2.ZERO,Vector2.ZERO)
	area = $Area2D
	area.area_entered.connect(_on_area_entered)

func check_curve():
	if(flip_y):
		for x in path.point_count:
			path.set_point_position(x,Vector2(path.get_point_position(x).x,path.get_point_position(0).y+(path.get_point_position(0).y - path.get_point_position(x).y)))
			path.set_point_in(x,Vector2(path.get_point_in(x).x,path.get_point_in(x).y*-1))
			path.set_point_out(x,Vector2(path.get_point_out(x).x,path.get_point_out(x).y*-1))



func _on_area_entered():
	health-=1
	if(health<1):
		death()
		

func death():
	GameController.change_points(point_value)
	call_deferred("free")

func enemy_init(h,p):
	health = h
	point_value = p

#For pathing, each enemy type will have use add_point() to add a series of points based on it's relative spawn pos
#and also set a pause timer (int) for how long it waits at point X(also set) before continuing on it's journey
#if pause timer = 0 have one continuous motion, otherwise smooth into and out of point x

func enemy_process(delta):
	match state:
		states.MOVINGIN:
			t +=(delta*delta_weight)
			position = path.sample_baked(t * speed, true)
			if(position.distance_to(path.get_point_position(pause_point)) <100):
				delta_weight*=0.96
				if(delta_weight<=0.2):
					state = states.STOPPED
					self.add_child(shoot_timer)
					shoot_timer.one_shot = true
					shoot_timer.start()
					shooting=true
					await get_tree().create_timer(pause_time).timeout
					shooting=false
					state = states.MOVINGOUT
					
		states.STOPPED:
			pass
		states.MOVINGOUT:
			delta_weight = clamp(delta_weight+0.06,0,1)
			t +=(delta*delta_weight)
			position = path.sample_baked(t * speed, true)
	
	




