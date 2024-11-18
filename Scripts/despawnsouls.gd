extends Node2D

@export_enum("Up:0","Down:1")var whichsouldirection: int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass






func _on_area_2d_area_entered(area):
	if area.is_in_group("soul"):
		 # Replace with function body.
		if area.get_parent().direction == whichsouldirection:
			print(area)
			area.get_parent().timebeforedeath()
