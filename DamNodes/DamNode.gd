extends Node2D

var game_over = true


# Called when the node enters the scene tree for the first time.
func _ready():
	for dam in $DamSections.get_children():
		dam.connect("Bust",get_parent(),"game_over")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewDamage_timeout(): #Create new damage if there is an undamaged dam pieces
	var undamaged = []
	
	for dam in $DamSections.get_children():
		if dam.eligible:
			undamaged.append(dam)
	#have array of undamaged dam sections
	if undamaged == []: #All dam sections are damaged
		print("No undamaged Dam Pieces")
		return
	else:
		print(undamaged)
	
	undamaged.shuffle()
	undamaged.front().damage()
	
	$NewDamage.wait_time = rand_range(9.0,12.0)


func end_game():
	$AudioStreamPlayer.play()
	for dam in $DamSections.get_children():
		dam.game_over = true
		dam.game_end()


func sink():
	if game_over:
		for dam in $DamSections.get_children():
			dam.sink()
		game_over = false
		


func get_water_delta():
	var water_delta = 0.0
	for dam in $DamSections.get_children():
		match dam.damage:
			0:
				pass
			1:
				water_delta += 0.1
			2:
				water_delta += 0.25
			3:
				water_delta += 0.5
			4:
				water_delta += 1.0
			5:
				water_delta += 1.5

	
	return water_delta


func _on_Game_game_over():
	end_game()
