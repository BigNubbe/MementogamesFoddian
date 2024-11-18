extends Node2D

var player
@export var speed = 30
var disablecoll
var modifier
var countdown = false
@onready var static_body_2d = $StaticBody2D
@onready var collshape_l = $StaticBody2D/CollshapeL

@onready var collshape_r = $StaticBody2D/CollshapeR

@export_enum("Up:0","Down:1") var direction: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match(direction):
	#change direction. using direction variable, if 0 go up, if 1 go down
		0:
			modifier = 1
		1:
			modifier = -1
	position += Vector2(0, -speed*delta*modifier)
	if player != null && direction == 0:
		player.canlatch = true

func _physics_process(delta):
	if Input.is_action_just_pressed("debuginput2"):
		timebeforedeath()
	# disabling collision from top, see onarea2dbodyentered below
	if disablecoll != null:
		collshape_l.disabled = disablecoll
		collshape_r.disabled = disablecoll
	else:
		collshape_l.disabled = false
		collshape_r.disabled = false
	
func setpos(posi: Vector2):
	#set spawning position
	position = posi
func setdir(dire: int):
	#set up or down
	direction = dire

func deleteself():
	queue_free()
	
func _on_area_2d_body_entered(body):
	#knockback the player if the souls move down, self-made comment the lines if unused
	if body.is_in_group("player"):
		player = body
		if direction == 1:
			if body.has_method("knockback"):
				body.knockback(200.0, global_position.x, 1)
		

func _on_area_2d_body_exited(body):
	if body == player:
		player = null


#make collision disabled, so player cant ride souls to the top
func _on_disabletop_body_entered(body):
	if body.is_in_group("player"):
		disablecoll = true
func _on_disabletop_body_exited(body):
	if body.is_in_group("player"):
		disablecoll = false

func _on_timer_timeout():
	deleteself()
	
func timebeforedeath():
	countdown = true
	var timmer = Timer.new()
	add_child(timmer)
	timmer.wait_time = 2.5
	timmer.start()
	timmer.timeout.connect(_on_timer_timeout)
	
