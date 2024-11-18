extends Node2D

@onready var respawntime = $respawntime
@onready var breaktime = $breaktime
@onready var static2d = $StaticBody2D
@onready var area2d = $Area2D
@onready var sprite  = $WUntitled
@onready var standon_coll = $StaticBody2D/StandonColl
@onready var areacheckcoll = $Area2D/Areacheckcoll


var duratime
var spawntime
# Called when the node enters the scene tree for the first time.
func _ready():
	duratime = 1
	spawntime = 3
	breaktime.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(breaktime.is_stopped())
	if breaktime.time_left < 0.5 && !breaktime.is_stopped():
		sprite.self_modulate = Color.RED
	else:
		sprite.self_modulate = Color.WHITE




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		breaktime.start(duratime)


func _on_area_2d_body_exited(body):
	pass # Replace with function body.


func _on_breaktime_timeout():
	standon_coll.disabled = true
	areacheckcoll.disabled = true
	sprite.visible = false
	respawntime.start(spawntime)
	breaktime.stop()


func _on_respawntime_timeout():
	standon_coll.disabled = false
	areacheckcoll.disabled = false
	sprite.visible = true # Replace with function body.
	respawntime.stop()
