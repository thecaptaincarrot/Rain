extends KinematicBody2D

var motion = Vector2(0,0)
var acceleration = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	
	if motion.length() > 40.0:
		motion = motion.normalized() * 40.0
	
	motion = move_and_slide(motion)
	
	animation_handler()
	
#	motion = lerp(motion, Vector2(0,0), .01)


func _input(event):
	if Input.is_action_pressed("up"):
		motion.y = Vector2(0,-1).y * acceleration
	elif Input.is_action_pressed("down"):
		motion.y = Vector2(0,1).y * acceleration
	else:
		motion.y = lerp(motion.y, 0, .99)
	
	if Input.is_action_pressed("right"):
		motion.x = Vector2(1,0).x * acceleration
	elif Input.is_action_pressed("left"):
		motion.x = Vector2(-1,0).x * acceleration
	
	
	
	else:
		motion.x = lerp(motion.x, 0, .99)


func animation_handler():
	if motion.x < -1:
		$PlayerSprite.flip_h = true
	elif motion.x > 1:
		$PlayerSprite.flip_h = false
	
	
	if motion.length() < 1.0:
		$PlayerSprite.animation = "Stand"
	else:
		$PlayerSprite.animation = "Run"
