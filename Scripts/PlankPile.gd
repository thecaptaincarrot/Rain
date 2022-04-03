extends StaticBody2D

var planks = 999 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PickArea_body_entered(body):
	if body.is_in_group("Player"):
		body.plank_pickup = self


func _on_PickArea_body_exited(body):
	if body.is_in_group("Player"):
		body.plank_pickup = null
		
