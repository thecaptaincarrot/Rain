extends Node2D

var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	$Hundred.hide()
#	var int_value = int(value)
#	var ones = int_value % 10
#	var tens = (int_value - ones) / 10
#	var hundreds = (int_value - ones - tens) / 100
#
#	$Ten.frame = tens
#	$One.frame = ones
#
#	if hundreds > 0:
#		$Hundred.hide()
#		$Hundred.frame = hundreds
	$Word.text = str(value)
