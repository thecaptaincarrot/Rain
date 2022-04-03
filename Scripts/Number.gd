extends Node2D

var value = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ones = value % 10
	$Ones.frame = ones
	var tens = (value - ones) / 10
	if tens <= 0:
		$Tens.hide()
	else:
		$Tens.show()
	$Tens.frame = tens
	
	
