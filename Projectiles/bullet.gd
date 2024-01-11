extends Area2D
class_name Bullet

var speed = 10
var wave_mod = 0
var wave_size =5
var wave_frequency = 5
var direction = Vector2.ZERO
var pattern = "gravity"
#var spiral_mod = 0.01
var spawn_pos = Vector2(0,0)
var fading = false
#var circle_distance = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("begin")
	spawn_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#defining the bullet movement depending on the pattern specified in initiate()
	match pattern:
		"straight":
			position += direction*speed
		"wave":
			wave_mod+=delta*wave_frequency
			#may get the same effect below by removing the rotated() and orthogonal() components as they both do the same thing
			position += direction*speed+((direction.rotated(deg_to_rad(90)).normalized().orthogonal())*(wave_size*sin(wave_mod)-0.25))
		"spiral":
			##commented code below does a cool circling directional bullet
			#spiral_mod+=delta*10
			#position+=direction*speed
			#position+= Vector2(cos(spiral_mod) * 2, sin(spiral_mod) * 3)
			pass
			##Almost working spiral motion, just too fast
			#spiral_mod+=delta/5
			#circle_distance+=delta*200
			#position = Vector2(sin(spiral_mod*speed),(cos(spiral_mod*speed)))*circle_distance+spawn_pos
		"slowing":
			position+=direction*speed
			speed=max(speed-delta*5,1.5)
		"accelerating":
			position+=direction*speed
			speed=min(100,speed+delta*5)
		"gravity":
			speed=max(speed-2*delta,0)
			wave_mod+=delta*8
			position+=Vector2(5-wave_mod,direction.y*speed)




func initiate(spd,dir,pat,start,mask):
	#Used when class is instanced to set the speed, direction, pattern of the bullet and collion mask
	speed = spd
	direction = dir
	pattern = pat
	set_position(start)
	#2 for Player, 4 for Enemy
	set_collision_mask(mask)

func _on_area_entered(area):
	match area.get_collision_layer_value(2):
		true:
			GameController.change_points(-500)
		false:
			GameController.change_points(10)
	area.emit_signal("area_entered")
	call_deferred("free")



func _on_timer_timeout():
	$AnimationPlayer.play("end")
	set_deferred("monitoring",false)
	await $AnimationPlayer.animation_finished
	call_deferred("free")
