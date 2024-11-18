extends CharacterBody2D


@export var SPEED:float = 300.0
@export var JUMP_VELOCITY:float = -700
var latching
var jumpcount
var coyotetime
var bascoytime
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#default gravity == 980
@export var gravity = 980 
var canlatch = false
var controlloss
func _ready():
	print(get_viewport_rect())
	bascoytime = 0.3
	coyotetime = bascoytime
	Camcontroller.player = self
	controlloss = 0.4
	
func _physics_process(delta):
	# Add the gravity.
	if controlloss >= 0:
		controlloss -= delta
	if not is_on_floor():
		if is_on_wall():
			#coyote time reset if on wall, so you can jump after latching
			#hold button to latch to wall,
			if Input.is_action_pressed("Latch") && canlatch == true:
				resetcoyotetime(bascoytime)
				#velocity becomes 0 but still pushed down because velocity.y still added by gravxdelta below
				velocity.y = 0
				latching = true
				resetjump(1)
			else:
				latching = false
		elif !is_on_wall():
			coyotetime -= delta
			canlatch = false
		if coyotetime <= 0:
			resetjump(0)
			#gravity always counts, wall latching still pushes char down but slower
		velocity.y += gravity * delta
		
	if is_on_floor():
		resetjump(1)
		resetcoyotetime(bascoytime)
		
		
	# Handle jump.
	if controlloss <= 0:
		if Input.is_action_just_pressed("ui_accept") and jumpcount > 0:
			if !is_on_wall():
				velocity.y = JUMP_VELOCITY
				jumpcount -= 1
			elif is_on_wall() && is_on_floor():
				velocity.y = JUMP_VELOCITY
				jumpcount -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if controlloss <= 0:
		if direction && !latching:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("transition"):
		Camcontroller.passedtransition = area
		Camcontroller.updatesituation()

func resetjump(jumpnum):
	#resets jump amount by jumpnum. maybe if want to have multiple midair jumps, increase coyotetime also
	if jumpcount != jumpnum:
		jumpcount = jumpnum
	else:
		pass
func resetcoyotetime(time):
	#a buffer so that player can still jump while not on ground, keep number(time) small to make jumping tighter and challenging
	coyotetime = time

func knockback(force: float, xpos: float, upforce: float):
	if xpos < global_position.x:
		#if obj pos/xpos bigger than player position (AKA object is on the left), knock player to the right
		velocity = Vector2(force * 2, -force* upforce)
		controlloss = 0.4
		move_and_slide()
	else:
		velocity = Vector2(-force * 2, -force* upforce)
		controlloss = 0.4
		move_and_slide()
