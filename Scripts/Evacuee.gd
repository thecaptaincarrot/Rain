extends Node2D

var movement_speed = 10
var alive = true
var leaving = false

signal Footprint

# Called when the node enters the scene tree for the first time.
func _ready():
	$Skin.frame = 0
	$Shirt.frame = 0
	$Shirt.modulate.s = .5
	$Shirt.modulate.h = rand_range(0,1.0)
	$Pants.frame = 0
	$Pants.modulate.s = .3
	$Pants.modulate.h = rand_range(0,1.0)


func _physics_process(delta):
	if alive:
		position.x += movement_speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func kill():
	alive = false
	$Skin.play("Float")
	$Shirt.play("Float")
	$Pants.play("Float")
	$Shadow.hide()


func _on_Pants_frame_changed():
	if $Pants.frame == 0 or $Pants.frame == 4 and alive:
		emit_signal("Footprint",position)
