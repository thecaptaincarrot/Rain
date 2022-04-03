extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for river in $Node2D.get_children():
		var frame = randi() % 12
		river.frame = frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
