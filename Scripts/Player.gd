extends KinematicBody2D

enum {ACTIVE, REPAIRING, DRAGGING,DEAD}
var state

var mud_factor = 1.0 #Slows player down
var water_level = 0.0 #Slows player down

var dead_safety = false

var drag_left = false #for log dragging

var motion = Vector2(0,0)
var  acceleration = 40
var  base_acceleration = 40
var drag_acceleration = 20
var  base_drag_acceleration = 20

var carrying_plank = false

#node assignment variables
var plank_pickup = null #in an area to pickup a plank
var repair_node = null #in an area to repair a damn
var log_pickup = null #in an area to pick up a log
var dragged_log = null #log being dragged

var active = true

signal DropPlank
signal Footprint

# Called when the node enters the scene tree for the first time.
func _ready():
	state = ACTIVE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Slowdown due to mud
	mud_factor = 1.0 - (.5 * water_level / 100.0)
	acceleration = base_acceleration * mud_factor
	drag_acceleration = base_drag_acceleration * mud_factor
	
	if dead_safety and state != DEAD:
		die()


func _physics_process(delta):
	
	if motion.length() > 40.0:
		motion = motion.normalized() * 40.0
	
	if motion.length() > 1.0:
		if water_level > 30:
			$MudParticles.emitting = true
		if water_level > 75:
			$WaterParticles.emitting = true
	else:
		$MudParticles.emitting = false
		$WaterParticles.emitting = false
	
	motion = move_and_slide(motion)
	
	animation_handler()
	
#	motion = lerp(motion, Vector2(0,0), .01)


func _input(event):
	match state:
		REPAIRING:
			return
		ACTIVE:
			#movement
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
			
			if Input.is_action_just_pressed("action"):
				#context specific
				if !carrying_plank:
					if log_pickup:
						dragged_log = log_pickup.pickup_log()
						state = DRAGGING
					elif plank_pickup:
						if plank_pickup.num_planks > 0:
								plank_pickup.num_planks -= 1
								carrying_plank = true
				else: #I am carrying a plank
					if repair_node:
						if repair_node.get_damage():
							carrying_plank = false
							repair_node.repair()
							state = REPAIRING
							
							motion = Vector2(0,0)
							$HammerTimer.start()
						else: #Put down plank
							emit_signal("DropPlank")
							carrying_plank = false
					else:
						if plank_pickup and plank_pickup.is_in_group("Maker"):
							plank_pickup.num_planks += 1
							carrying_plank = false
						else: #Put down plank
							emit_signal("DropPlank")
							carrying_plank = false

		DRAGGING:
			motion.y = 0
			if drag_left:
				if Input.is_action_pressed("left"):
					motion.x = Vector2(-1,0).x * drag_acceleration
				else:
					motion.x = lerp(motion.x, 0, .99)
			else:
				if Input.is_action_pressed("right"):
					motion.x = Vector2(1,0).x * drag_acceleration
				else:
					motion.x = lerp(motion.x, 0, .99)
			
			if Input.is_action_just_pressed("action"):
				#Put down the log
				if dragged_log:
					#move log to current position
					dragged_log.global_position = global_position
					dragged_log.show()
					
					log_pickup = dragged_log
					
					dragged_log = null
					
					state = ACTIVE


func die():
	state = DEAD
	$PlayerSprite.play("Dead")
	$Shadow.hide()
	motion = Vector2(0,0)
	dead_safety = true


func log_to_plank():
	dragged_log.queue_free()
	dragged_log = null
	log_pickup = null
	state = ACTIVE


func animation_handler():
	if state == ACTIVE:
		$LogLeft.hide()
		$LogRight.hide()
		if motion.x < -1:
			$PlayerSprite.flip_h = true
		elif motion.x > 1:
			$PlayerSprite.flip_h = false
		
		if carrying_plank:
			if motion.length() < 1.0:
				$PlayerSprite.animation = "PlankStand"
			else:
				$PlayerSprite.animation = "PlankRun"
		else:
			if motion.length() < 1.0:
				$PlayerSprite.animation = "Stand"
			else:
				$PlayerSprite.animation = "Run"
		
	elif state == REPAIRING:
		$PlayerSprite.animation = "Hammer"
		
	elif state == DRAGGING:
		$PlayerSprite.flip_h = drag_left
		
		if drag_left:
			$LogRight.show()
			$LogLeft.hide()
		else:
			$LogRight.hide()
			$LogLeft.show()
			
		
		if motion.length() < 1.0:
			$PlayerSprite.animation = "LogStand"
		else:
			$PlayerSprite.animation = "LogPull"
	
	#Action "!"
	if state == ACTIVE:
		if carrying_plank:
			if repair_node:
				if repair_node.get_damage():
					$Action.show()
			elif plank_pickup:
				if plank_pickup.is_in_group("Maker"):
					$Action.show()
				else:
					$Action.hide()
			else:
				$Action.hide()
		else: #not carrying plank
			if log_pickup:
				$Action.show()
			elif plank_pickup:
				if plank_pickup.num_planks > 0:
					$Action.show()
			else:
				$Action.hide()
	else:
		$Action.hide()


func _on_HammerTimer_timeout():
	state = ACTIVE


func _on_PlayerSprite_frame_changed(): #Sound Effects
	if $PlayerSprite.animation == "Hammer":
		if $PlayerSprite.frame == 1 :
			$Hammer.play()
	
	if $PlayerSprite.animation == "Run" or $PlayerSprite.animation == "PlankRun":
		if $PlayerSprite.frame % 2 == 0:
			emit_signal("Footprint", position)
		
		if $PlayerSprite.frame == 0  or $PlayerSprite.frame == 4:
			$FootSteps.play()
	
	if $PlayerSprite.animation == "LogPull":
		if !$LogDrag.is_playing():
			print("This should only happen like once")
			$LogDrag.play()
		if $PlayerSprite.frame % 3 == 0:
			emit_signal("Footprint", position)
		if $PlayerSprite.frame == 0  or $PlayerSprite.frame == 3:
			$FootSteps.play()
			
	else:
		$LogDrag.stop()
