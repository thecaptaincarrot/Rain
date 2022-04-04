extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Timer.wait_time = rand_range(5.0,15.0)
#	$Timer.wait_time = rand_range(2.0,4.0)
	if randi()%2:
		$AnimationPlayer.play("Single")
	else:
		$AnimationPlayer.play("SingleReal")
