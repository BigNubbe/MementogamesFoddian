extends Camera2D

var screensize
var curscreen = Vector2(0,0)
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	screensize = get_screen_center_position()
	print(get_screen_center_position())


# Called every frame. 'delta' is the elapsed time since the previous frame.func _physics_process(delta):
	var playerloc = (player.global_position / screensize).floor()
	if !playerloc.is_equal_approx(curscreen):
		updatescreen(playerloc)
		

func updatescreen(newscreen: Vector2):
	curscreen = newscreen
	global_position = curscreen * screensize + screensize *0.5
	
	
