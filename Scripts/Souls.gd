extends Node

var upspawner1
var upspawner2
var downspawner1
const latchableobject = preload("res://Scenes/latchable.tscn")
var debugspawnnum = 0
var debuglastobject

# Called when the node enters the scene tree for the first time.
func _ready():
	upspawner1 = get_parent().get_node("UpSpawnerBot")
	upspawner2 = get_parent().get_node("UpSpawnerBot2")
	downspawner1 = get_parent().get_node("DownSpawnerTop")
	spawn(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debuginput"):
		deleteobject()
		spawn(debugspawnnum)
		if debugspawnnum < 2:
			debugspawnnum += 1
		else:
			debugspawnnum = 0
	
func spawn(where: int):
	var spawnsouls = latchableobject.instantiate()
	debuglastobject = spawnsouls
	match where:
		0:
			spawnsouls.setpos(upspawner1.position)
		1:
			spawnsouls.setpos(upspawner2.position)
		2:
			spawnsouls.setpos(downspawner1.position)
			spawnsouls.setdir(1)
	add_child(spawnsouls)

func deleteobject():
	if debuglastobject != null:
		debuglastobject.deleteself()
