extends Control

@onready var lives_ui = $HBoxContainer/Lives
@onready var bombs_ui = $HBoxContainer/Bombs
@onready var points_ui = $HBoxContainer/Power
@onready var power_ui = $HBoxContainer/Points
# Called when the node enters the scene tree for the first time.
func _ready():
	_ui_update()
	GameController.update_ui.connect(_ui_update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ui_update():
	lives_ui.text = "Lives: %d"%GameController.lives
	bombs_ui.text = "Bombs: %d"%GameController.bombs
	points_ui.text = "Points: %d"%GameController.points
	power_ui.text = "Power: %d"%GameController.power
