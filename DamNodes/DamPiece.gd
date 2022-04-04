extends AnimatedSprite

export var damage = 0

var game_over = false
var eligible = true

signal Bust

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
			$Danger1.hide()
			$Danger2.hide()
			$Danger3.hide()
		1:
			play("Damage1")
			$Danger1.hide()
			$Danger2.hide()
			$Danger3.hide()
		2:
			play("Damage2")
			$Danger1.hide()
			$Danger2.hide()
			$Danger3.hide()
		3:
			play("Damage3")
			$Danger1.hide()
			$Danger2.hide()
			$Danger3.hide()
		4:
			play("Damage4")
			$Danger1.hide()
			$Danger2.hide()
			$Danger3.hide()
		5:
			play("Damage5")
			$Danger1.show()
			$Danger2.show()
			$Danger3.show()


func game_end():
	$Spill.show()
	$Spill.play()
	play("Damage6")
	damage = 0
	$DamageTimer.stop()


func sink():
	play("Sink")
	$Spill.hide()
	$Danger1.hide()
	$Danger2.hide()
	$Danger3.hide()
	damage = 0
	$DamageTimer.stop()


func damage():
	eligible = false
	if damage <5:
		damage += 1
	else:
		emit_signal("Bust")
	$DamageTimer.wait_time = rand_range(10.0,12.0)
	$DamageTimer.start()


func repair():
	damage = 0
	$DamageTimer.stop()
	$DoNotDamageTimer.start()


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


func _on_DoNotDamageTimer_timeout():
	eligible = true # Replace with function body.
