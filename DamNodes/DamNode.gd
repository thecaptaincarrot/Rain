extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewDamage_timeout(): #Create new damage if there is an undamaged dam pieces
	var undamaged = []
	
	for dam in $DamSections.get_children():
		if !dam.get_damage():
			undamaged.append(dam)
	#have array of undamaged dam sections
	if undamaged == []: #All dam sections are damaged
		print("No undamaged Dam Pieces")
		return
	else:
		print(undamaged)
	
	undamaged.shuffle()
	undamaged.front().damage()


func end_game():
	for dam in $DamSections.get_children():
		dam.game_over = true
		dam.game_end()


func get_water_delta():
	var water_delta = 0.0
	for dam in $DamSections.get_children():
		match dam.damage:
			0:
				pass
			1:
				water_delta += 50.1
			2:
				water_delta += 10.25
			3:
				water_delta += .5
			4:
				water_delta += 1
	
	return water_delta


func _on_Game_game_over():
	end_game()
