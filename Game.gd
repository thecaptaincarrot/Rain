extends Node2D

const PLANK = preload("res://DroppedPlank.tscn")

var water_level = 0.0

signal game_over


# Called when the node enters the scene tree for the first time.
func _ready():
	for maker in $Planks.get_children():
		maker.player = $Player
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var water_delta = $DamNode.get_water_delta()
	water_level += water_delta * delta
	$HUD/Percentage.value = water_level
	
	if water_level >= 100.0:
		emit_signal("game_over")


func _on_Player_DropPlank():
	var new_plank = PLANK.instance()
	new_plank.position = $Player.position
	$Planks.add_child(new_plank)
