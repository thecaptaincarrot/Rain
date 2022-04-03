extends Node

const PERSON = preload("res://Evacuation/Evacuee.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KillZone_area_entered(area):
	if area.is_in_group("Evacuee"):
		area.get_parent().queue_free()


func _on_EvacueeTimer_timeout():
	#Spawn Evacuee
	#Add different types?
	var new_evacuee = PERSON.instance()
	new_evacuee.position = $EvacueeSpawnPoint.position + Vector2(randi() % 32,randi() % 32)
	new_evacuee.connect("Footprint",get_parent(),"EvacueeFootprint")
	$People.add_child(new_evacuee)
	$EvacueeTimer.wait_time = rand_range(1.5,3.0)


func kill_all():
	for person in $People.get_children():
		person.kill()
	$EvacueeTimer.stop()
