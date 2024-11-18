extends Node

var camnum
var currlevel
var activecam
var transitionnumber = []
var passedtransition
var GameRoot
var player
var camspots = []
# Called when the node enters the scene tree for the first time.
func _ready():
	#make an area2d and add to group "transition"
	currlevel = 1
	camnum = currlevel
	#adds the area 2ds into an array
	transitionnumber.push_back(get_tree().get_nodes_in_group("transition"))
	#fill camspots's array with nodes with group(make sure to add group on the area2d node)
	#nubbenote: Make a scene for the "Camcenter"/camera spots
	camspots = get_tree().get_nodes_in_group("camspots")
	print(GameRoot)
	if GameRoot != null:
		for child in GameRoot.find_children("*"):
			if child.is_in_group("player"):
				player = child
				print("player = child brs")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func swapcams(camnum):
	#when area2d is touched, call this
	activecam = GameRoot.get_node("Camera1")
	if camspots != null:
		#swaps the cam to the argument's index. index starts at 0
		activecam.position = camspots[camnum-1].position
	#if activecam != null:
		#activecam.make_current()
	#print(activecam)
	#if currlevel == 2:
			#currlevel -= 1
			#activecam = get_parent().get_node("Camera"+str(currlevel))
	#elif currlevel == 1:
			#currlevel += 1
			#activecam = get_parent().get_node("Camera"+str(currlevel))


func _on_area_2d_body_entered(body):
	pass

func updatesituation():
	pass
	match passedtransition.name:
		"Transition1":
			if currlevel == 1:
				currlevel = 2
			else:
				currlevel = 1
		"Transition2":
			if currlevel == 2:
				currlevel = 3
			else:
				currlevel = 2
	swapcams(currlevel)
