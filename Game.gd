extends Node2D

const PLANK = preload("res://DroppedPlank.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for maker in $Planks.get_children():
		maker.player = $Player
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_DropPlank():
	var new_plank = PLANK.instance()
	new_plank.position = $Player.position
	$Planks.add_child(new_plank)
