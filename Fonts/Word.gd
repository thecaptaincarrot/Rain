tool
extends Node2D

const LETTER = preload("res://Fonts/Letter.tscn")

export var text = "HELLO WORLD"
var display_text = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if text != display_text:
		for child in get_children():
			child.queue_free()
		
		#Centering
		var length = len(text)
		
		var offset = length * -2.75
		var i = 0
		
		for letter in text:
			var new_letter = LETTER.instance()
			if letter_to_number(letter):
				new_letter.frame = letter_to_number(letter)
			else:
				pass
			new_letter.position.x = offset + i * 5.5
			i += 1
			add_child(new_letter)
			
		display_text = text


func letter_to_number(letter : String):
	var caps = letter.to_upper()
	match caps:
		"A":
			return 0
		"B":
			return 1
		"C":
			return 2
		"D":
			return 3
		"E":
			return 4
		"F":
			return 5
		"G":
			return 6
		"H":
			return 7
		"I":
			return 8
		"J":
			return 9
		"K":
			return 10
		"L":
			return 11
		"M":
			return 12
		"N":
			return 13
		"O":
			return 14
		"P":
			return 15
		"Q":
			return 16
		"R":
			return 17
		"S":
			return 18
		"T":
			return 19
		"U":
			return 20
		"V":
			return 21
		"W":
			return 22
		"X":
			return 23
		"Y":
			return 24
		"Z":
			return 25
		":":
			return 26
		"0":
			return 27
		"1":
			return 28
		"2":
			return 29
		"3":
			return 30
		"4":
			return 31
		"5":
			return 32
		"6":
			return 33
		"7":
			return 34
		"8":
			return 35
		"9":
			return 36
		" ":
			return 37
	return false
