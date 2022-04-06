extends Node2D

const LINE = preload("res://FootprintLine.tscn")
const PLANK = preload("res://DroppedPlank.tscn")
const PRINT = preload("res://FootPrints.tscn")

var water_level = 0.0

var points = 0

onready var current_footprints = $Footprints/Footprints2

var game_over = false
var can_reset = false
signal game_over


# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/Credits/CreditsRoll.interpolate_property($HUD/Credits/, "position",Vector2(188,274),Vector2(188,-430), 30.0)
	
	for maker in $Planks.get_children():
		maker.player = $Player
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HUD/Score.value = points
	if !game_over:
		var water_delta = $DamNode.get_water_delta()
		if water_level < 100.0:
			water_level += water_delta * delta
		else:
			water_level = 100.0
		$HUD/Percentage.value = water_level
		
		var mud_percent = water_level / 100
		if mud_percent > 1.0:
			mud_percent = 1.0
		$Scenery/MuddyGround.modulate.a = (mud_percent)
		
		$Player.water_level = water_level


func _input(event):
	if can_reset and Input.is_action_pressed("action"):
		get_tree().change_scene("res://Game.tscn")


func game_over():
	emit_signal("game_over")
	game_over = true


func _on_Player_DropPlank():
	var new_plank = PLANK.instance()
	new_plank.position = $Player.position
	$Planks.add_child(new_plank)


func _on_FadeIn_tween_all_completed():
	$HUD/Whiteout/FadeOut.start()
	$HUD/Whiteout/FadeIn.stop_all()
	#Show water
	$Scenery/River.hide()
	$Scenery/DeepRiver.show()
	#change all sprites to flooded versions
	$DamNode.sink()
	$Player.die()
	$Planks.hide()
	$Footprints.hide()
	$Evacuees.kill_all()
	$DroppedPlanks.hide()
	$HUD/Credits/FinalScore.text = str(points)
	#Show end screen and credits
	$HUD/Credits/CreditsRoll.start()
	$ResetTimer.start()


func _on_Exit_area_entered(area):
	if area.is_in_group("Evacuee"):
		points += 1
		print(points)


func _on_Player_Footprint(pos):
#	var new_print = PRINT.instance()
#	new_print.position = $Player.position
#	$Footprints.add_child(new_print)
	current_footprints.add_point(pos)
	if current_footprints.get_point_count() > 4000:
		var new_prints = LINE.instance()
		current_footprints = new_prints
		$Footprints.add_child(new_prints)


func EvacueeFootprint(place):
	if len($Footprints.get_children()) < 1000:
		var new_print = PRINT.instance()
		new_print.position = place
		$Footprints.add_child(new_print)


func _on_ResetTimer_timeout():
	can_reset = true
