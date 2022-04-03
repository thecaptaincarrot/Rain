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
