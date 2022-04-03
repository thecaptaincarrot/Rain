extends Area2D

var num_planks = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if num_planks <= 0:
		queue_free()


func _on_Plank_body_entered(body):
	if body.is_in_group("Player"):
		body.plank_pickup = self


func _on_Plank_body_exited(body):
	if body.is_in_group("Player") and body.plank_pickup == self:
		body.plank_pickup = null
