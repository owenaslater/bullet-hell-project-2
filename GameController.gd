extends Node
# Using this class to store game variables across levels

var lives = 4
var bombs = 3
var points = 0
var power = 0
var player

signal update_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func change_lives(amount):
	lives += amount
	emit_signal("update_ui")

func change_bombs(amount):
	bombs += amount
	emit_signal("update_ui")

func change_points(amount):
	points += amount
	emit_signal("update_ui")

func change_power(amount):
	power+=amount
	emit_signal("update_ui")

func start_level(levelnum):
	if(levelnum == 0):
		lives = 4
		bombs = 3
		points = 0
		power = 0
	#GTFO child 1 of root (child 0 is the autoload script)
	get_tree().get_root().get_child(1).call_deferred("free")
	#This needs to be able to load any level based on a standardised naming convention for levels
	var stlevel = load("res://Levels/level_%d.tscn" % levelnum).instantiate()
	get_tree().get_root().add_child(stlevel)
	var player_path = "/root/level_%d/Player"%levelnum
	print(player_path)
	while(!has_node(player_path)):
		print("player not ready yet")
		await get_tree().create_timer(1.0).timeout
	on_level_start()
	

func on_level_start():
	player = get_node("/root/level_99/Player")
	player.death.connect(change_lives.bind(-1))
	player.bomb.connect(change_bombs.bind(-1))
	



