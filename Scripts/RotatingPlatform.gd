extends Node2D
#Keep rotspeed around 1-7
@export var rotspeed: float
#select type from inspector
@export_enum("Rotating","Illusory","Invisible") var platformtype: String

var distancebetween
var maxdist
@onready var sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	maxdist = 650


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Camcontroller.player == null:
		distancebetween = (get_global_mouse_position() - self.position).length()
	else:
		distancebetween = (Camcontroller.player.global_position - self.position).length()
	match platformtype:
		"Rotating":
			speen(delta)
		"Illusory":
			illuse()
		"Invisible":
			invis()
	
	

func speen(framemod):
	self.rotation += rotspeed * framemod

func illuse():
	#control distance visible with maxdist variable
	if distancebetween > maxdist:
		sprite.modulate = Color(sprite.modulate, 1)
	else:
		sprite.modulate = Color(sprite.modulate,(distancebetween/maxdist -0.025))

func invis():
		sprite.modulate = Color(sprite.modulate,(1.2 - distancebetween/(maxdist * 0.56)))
		
		
