extends CharacterBody2D

#Player character controls and states
@export var Bullet: PackedScene
@onready var shoot_timer = $ShootTimer
@onready var bomb_timer = $BombTimer

const SPEED = 700
var shot_speed = 0.05
signal bomb
signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer.wait_time=shot_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2(0,0)
	velocity = Vector2(0,0)
	var shift_mod=1
	
	#Movement input
	if(Input.is_action_pressed("Move_Left")):
		direction = Vector2(-1,0)
	if(Input.is_action_pressed("Move_Right")):
		direction += Vector2(1,0)
	if(Input.is_action_pressed("Move_Up")):
		direction += Vector2(-0,-1)
	if(Input.is_action_pressed("Move_Down")):
		direction += Vector2(0,1)
	if(Input.is_action_pressed("Slow")):
		shift_mod = 0.5
	if(direction!=Vector2.ZERO):
		velocity = direction * SPEED * shift_mod 
	move_and_slide()
	
	#Player actions
	if(Input.is_action_pressed("Shoot")&&shoot_timer.is_stopped()):
		shoot_timer.start()
		var b = Bullet.instantiate()
		b.initiate(20,Vector2(1,0)+(direction/8),"straight",get_position(),4)
		self.get_parent().add_child(b)
	if(Input.is_action_just_pressed("Bomb")&&bomb_timer.is_stopped()):
		emit_signal("bomb")
		bomb_timer.start()
		
		


##For when the player gets hit and dies
func _on_hurtbox_area_entered():
	emit_signal("death")
	$Hurtbox.call_deferred("set_monitorable",false)
	$Body.call_deferred("set_visible",false)
	await get_tree().create_timer(2.0).timeout
	$Body.call_deferred("set_visible",true)
	await get_tree().create_timer(2.0).timeout
	$Hurtbox.call_deferred("set_monitorable",true)
	
