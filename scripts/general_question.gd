extends Control

var title = ""
var option1 = ""
var option2 = ""
var option3 = ""
var option4 = ""
var correct_answer = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func option_1():
	if get_meta("correct_answer") == 1:
		return true
	return false
	
func option_2():
	if get_meta("correct_answer") == 2:
		return true
	return false
	
func option_3():
	if get_meta("correct_answer") == 3:
		return true
	return false
	
func option_4():
	if get_meta("correct_answer") == 4:
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Label.text = title
	$CanvasLayer/Choice1.text = option1
	$CanvasLayer/Choice2.text = option2
	$CanvasLayer/Choice3.text = option3
	$CanvasLayer/Choice4.text = option4
