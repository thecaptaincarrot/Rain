extends AnimatedSprite

export var damage = 0

var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !game_over:
		damage_handler()


func damage_handler(): #animation and any other checks
	match damage:
		0:
			play("Damage0")
			if !$DamageTimer.is_stopped():
				$DamageTimer.stop()
		1:
			play("Damage1")
		2:
			play("Damage2")
		3:
			play("Damage3")
		4:
			play("Damage4")


func game_end():
	$Spill.show()
	$Spill.play()
	play("Damage5")
	


func damage():
	if damage <4:
		damage += 1
	$DamageTimer.start()


func repair():
	damage = 0
	$DamageTimer.stop()


func get_damage():
	return damage


func _on_RepairArea_body_entered(body):
	if body.is_in_group("Player"):
		body.repair_node = self


func _on_RepairArea_body_exited(body):
	if body.is_in_group("Player"):
		if body.repair_node == self:
			body.repair_node = null


func _on_DamageTimer_timeout():
	damage()
