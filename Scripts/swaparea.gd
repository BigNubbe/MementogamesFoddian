extends Area2D

@export var mynum: int



func _on_body_entered(body):
	#when player enter the area, check the current level from globals(camcontroller)
	if body.is_in_group("player"):
		if Camcontroller.currlevel >= mynum:
			#currlevel goes down
			Camcontroller.currlevel = mynum -1
			
			
		elif Camcontroller.currlevel < mynum:
			#currlevel goes up
			Camcontroller.currlevel = mynum
			
		#swapcams's argument is going to be used to select a camera spot index
		#swapcam's index counts it as -1 so double minus if you want to go down
		#ex: if currlevel = 2 then player drops a level then swapcams will read as 0 form currlevel = 1(mynum is 2 then minus one) 
		#swapcams index form: camspots[currlevel - 1]
		Camcontroller.swapcams(Camcontroller.currlevel)


func _on_body_exited(body):
	if body.is_in_group("player"):
		if Camcontroller.player.velocity.y > 0:
			Camcontroller.currlevel = mynum -1
		else:
			Camcontroller.currlevel = mynum
		Camcontroller.swapcams(Camcontroller.currlevel)
