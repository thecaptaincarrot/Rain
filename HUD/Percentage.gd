extends Node2D

var value = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if value >= 100.0:
		value = 100.0
		$Hundred.show()
		$Hundred.frame = 1
		$Ten.frame = 0
		$One.frame = 0
		$Decimal.frame = 0
	else:
		$Hundred.hide()
		var decimal = value - floor(value)
		var int_value = int(value - decimal)
		var ones = int_value % 10
		var tens = (int_value - ones) / 10
		
		$Ten.frame = tens
		$One.frame = ones
		$Decimal.frame = stepify(decimal * 10,1)
		
		
