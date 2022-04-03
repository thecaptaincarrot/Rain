extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func pickup_log():
	hide()
	return self


func _on_PickupArea_body_entered(body):
	if body.is_in_group("Player"):
		body.log_pickup = self


func _on_PickupArea_body_exited(body):
	if body.is_in_group("Player"):
		if body.log_pickup == self:
			body.log_pickup = null
