extends Node2D

const LOG = preload("res://PlankMaker/Log.tscn")

var player = null

var num_planks = 0
var queued_planks = 0

var full = false
var dropping_off = false

export var drag_left = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#light
	if player:
		if player.global_position.y < global_position.y:
			$PlankPile/PlankLight.enabled = true
		else:
			$PlankPile/PlankLight.enabled = false
	
	plank_handler()
	
	if queued_planks > 0 and !full:
		queued_planks -= 1
		full = true
		$SawBody/LogCut.play("LogCut")
		#put a log on the plank maker
	
	$PlankPile/Number.value = num_planks
	

func pickup_log():
	var new_log = LOG.instance()
	new_log.position = $LogBody/LogPickupArea.position
#	if !drag_left:
#		new_log.scale.x = -1
	new_log.hide()
	$Logs.add_child(new_log)
	return new_log


func add_plank():
	full = true
	$SawBody/LogCut.play()


func plank_handler():
	#change collision shapes based on number of planks TODO
	#Change sprite based on number of planks
	#collision shape
	if num_planks > 0:
		$PlankPile/PlankCollider.disabled = false
	else:
		$PlankPile/PlankCollider.disabled = true
	
	var display_planks = round((num_planks + 1) / 3.0)
	
	#Frames
	if display_planks < 5:
		$PlankPile/PlankSprite.frame = display_planks
	else:
		$PlankPile/PlankSprite.frame = 5
	
	if display_planks <= 1:
		$PlankPile/PlankLight.enabled = false
	elif display_planks == 2:
		$PlankPile/PlankLight.position.y = 4
		$PlankPile/PlankLight.scale.y = 0.125
	elif display_planks == 3:
		$PlankPile/PlankLight.position.y = 3
		$PlankPile/PlankLight.scale.y = 0.156
	elif display_planks == 4:
		$PlankPile/PlankLight.position.y = 2
		$PlankPile/PlankLight.scale.y = 0.187
	else:
		$PlankPile/PlankLight.position.y = 1
		$PlankPile/PlankLight.scale.y = 0.219

	
	pass


func _on_LogPickupArea_body_entered(body):
	if body.is_in_group("Player"):
		body.log_pickup = self
		body.drag_left = drag_left


func _on_LogPickupArea_body_exited(body):
	if body.is_in_group("Player"):
		body.log_pickup = null


func _on_LogDropboffArea_body_entered(body):
	if body.is_in_group("Player"):
		if body.state == body.DRAGGING: # does this hit false positives?
			print("Dropped Off")
			body.log_to_plank()
			queued_planks += 1


func _on_LogCut_animation_finished(anim_name):
	num_planks += 2
	full = false
	$AudioStreamPlayer.play()


func _on_PlankPickupArea_body_entered(body):
	if body.is_in_group("Player"):
		print("hello player")
		body.plank_pickup = self


func _on_PlankPickupArea_body_exited(body):
	if body.is_in_group("Player"):
		body.plank_pickup = null
