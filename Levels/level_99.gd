extends LevelDefaults


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2.0).timeout
	spawn_enemy("Demo_enemy",0.8,"up",1,"up")
	await get_tree().create_timer(2.0).timeout
	spawn_enemy("enemy_02",0.1,"up",4,"right")
	await get_tree().create_timer(0.5).timeout
	spawn_enemy("enemy_02",0.9,"up",4,"right")
	await get_tree().create_timer(3.0).timeout
	spawn_enemy("enemy_01",0.4,"down",3,"up")
	await get_tree().create_timer(2).timeout
	spawn_enemy("Demo_enemy",0.1,"down",4,"downright")
