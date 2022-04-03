extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$FadeIn.interpolate_property(self,"color",Color(1.0,1.0,1.0,0.0),Color(1.0,1.0,1.0,1.0),1.0)
	$FadeOut.interpolate_property(self,"color",Color(1.0,1.0,1.0,1.0),Color(1.0,1.0,1.0,0.0),2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func fade_to_white():
	$FadeIn.start()


func fade_to_transparent():
	$Fadeout.start()


func _on_Game_game_over():
	fade_to_white()
