extends Node2D

var game_over = false

var question_poses = [[-1037, -664], [-571, -668], [-83, -663], [900, -40], [-29, 535]]
var question_sizes = [[134, 226], [347, 226], [64, 226], [140, 446], [140, 360]]

var question_titles = [
	"What company are you working for?",
	"What is the company dress code?",
	"If you have any company complaints, how should they be filed?",
	"How long can you take on your bathroom breaks?",
	"How much are you getting paid for this?"
]

var question_options = [
	["The Museum of Time", "The U.S. Government", "Time Variance Authority", "The Museum of Art"],
	["Casual", "Provided Uniform", "Business Casual", "Business Formal"],
	["Through HR", "Through your manager", "Through the appropriate higher up", "Stop complaining, we are a family, and\nall complaints should be dealt with as such"],
	["As long as you need", "Reasonable amount, accommodated for medical issues", "All breaks are off the clock", "Break time is 15 minutes every 2 hours"],
	["15 time coins per hour", "380,000 time coin salary", "100 time coin per day", "Exposure, experience, and valuable industry insights"]
]

var correct_answers = [1, 2, 4, 3, 4]

var pieces_collected = 0

var lives = 3

func pause():
	$UI/CanvasLayer.hide()
	$ColorRect.color = "00000099";
	get_tree().paused = true
	$PauseMenu/CanvasLayer.show()

func unpause():
	$PauseMenu/CanvasLayer.hide()
	get_tree().paused = false
	$UI/CanvasLayer.show()
	$ColorRect.color = "00000000";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Question.title = question_titles[0]
	$Question.option1 = "A: " + question_options[0][0]
	$Question.option2 = "B: " + question_options[0][1]
	$Question.option3 = "C: " + question_options[0][2]
	$Question.option4 = "D: " + question_options[0][3]
	$Question/CanvasLayer.hide()
	
	$QuestionTrigger/Area2D/CollisionShape2D.position.x = question_poses[0][0]
	$QuestionTrigger/Area2D/CollisionShape2D.position.y = question_poses[0][1]
	$QuestionTrigger/Area2D/CollisionShape2D.shape.size.x = question_sizes[0][0]
	$QuestionTrigger/Area2D/CollisionShape2D.shape.size.y = question_sizes[0][1]
	
	get_node("PauseMenu/CanvasLayer").hide()
	$UI/CanvasLayer.hide()
	$PiecesLivesUI/CanvasLayer.hide()
	$Player.hide()
	$TutorialMap.hide()
	$WinScreen/CanvasLayer.hide()
	$LoseScreen/CanvasLayer.hide()

func start_game():
	$Player.show()
	$UI/CanvasLayer.show()
	$PiecesLivesUI/CanvasLayer.show()
	$TutorialMap.show()
	$MainMenu/CanvasLayer.hide()
	$MainMenu/CanvasLayer/Button.text = "Continue working at the Museum of Time\n(and you will most definitely become very rich...)"
	
func back_to_menu():
	unpause()
	$UI/CanvasLayer.hide()
	$PiecesLivesUI/CanvasLayer.hide()
	$Player.hide()
	$TutorialMap.hide()
	$MainMenu/CanvasLayer.show()

func restart():
	unpause()
	$Player.position.x = -1033
	$Player.position.y = 207
	$Player.animation = "idle_down"
	pieces_collected = 0
	lives = 3
	
	$PiecesLivesUI/CanvasLayer/Life1.show()
	$PiecesLivesUI/CanvasLayer/Life2.show()
	$PiecesLivesUI/CanvasLayer/Life3.show()
	
	$Question.title = question_titles[0]
	$Question.option1 = "A: " + question_options[0][0]
	$Question.option2 = "B: " + question_options[0][1]
	$Question.option3 = "C: " + question_options[0][2]
	$Question.option4 = "D: " + question_options[0][3]
	
	$QuestionTrigger/Area2D/CollisionShape2D.position.x = question_poses[0][0]
	$QuestionTrigger/Area2D/CollisionShape2D.position.y = question_poses[0][1]
	$QuestionTrigger/Area2D/CollisionShape2D.shape.size.x = question_sizes[0][0]
	$QuestionTrigger/Area2D/CollisionShape2D.shape.size.y = question_sizes[0][1]

func display_question(body: Node):
	if body is Player:
		$UI/CanvasLayer.hide()
		$ColorRect.color = "00000099"
		$Question/CanvasLayer.show()
		
		get_tree().paused = true

func question_option1():
	if correct_answers[pieces_collected] == 1:
		correct_option()
	else:
		incorrect_option()

func question_option2():
	if correct_answers[pieces_collected] == 2:
		correct_option()
	else:
		incorrect_option()
	
func question_option3():
	if correct_answers[pieces_collected] == 3:
		correct_option()
	else:
		incorrect_option()

func question_option4():
	if correct_answers[pieces_collected] == 4:
		correct_option()
	else:
		incorrect_option()

func correct_option():
	get_tree().paused = false
	pieces_collected += 1
	
	if pieces_collected < 5:
		$Question/CanvasLayer.hide()
		$Question.title = question_titles[pieces_collected]
		$Question.option1 = "A: " + question_options[pieces_collected][0]
		$Question.option2 = "B: " + question_options[pieces_collected][1]
		$Question.option3 = "C: " + question_options[pieces_collected][2]
		$Question.option4 = "D: " + question_options[pieces_collected][3]
		
		$QuestionTrigger/Area2D/CollisionShape2D.position.x = question_poses[pieces_collected][0]
		$QuestionTrigger/Area2D/CollisionShape2D.position.y = question_poses[pieces_collected][1]
		$QuestionTrigger/Area2D/CollisionShape2D.shape.size.x = question_sizes[pieces_collected][0]
		$QuestionTrigger/Area2D/CollisionShape2D.shape.size.y = question_sizes[pieces_collected][1]
		
		$UI/CanvasLayer.show()
		$ColorRect.color = "00000000"
	
	else:
		$Question/CanvasLayer.hide()
		win_game()

func incorrect_option():
	lives -= 1
	if lives == 0:
		lose_game()
		return
	
	get_node("PiecesLivesUI/CanvasLayer/Life" + str(lives + 1)).hide()
	$ColorRect.color = "88000099"
	await get_tree().create_timer(0.25).timeout
	$ColorRect.color = "00000099"

func win_game():
	game_over = true
	$PiecesLivesUI/CanvasLayer.hide()
	$UI/CanvasLayer.hide()
	$TutorialMap.hide()
	$Player.hide()
	$Question/CanvasLayer.hide()
	$WinScreen/CanvasLayer.show()

func lose_game():
	game_over = true
	$PiecesLivesUI/CanvasLayer.hide()
	$UI/CanvasLayer.hide()
	$TutorialMap.hide()
	$Player.hide()
	$Question/CanvasLayer.hide()
	$LoseScreen/CanvasLayer.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not game_over:
		var x_dist_to_question = question_poses[pieces_collected][0] - $Player.position.x
		var y_dist_to_question = question_poses[pieces_collected][1] - $Player.position.y
		var dist_vector = Vector2(x_dist_to_question, y_dist_to_question)
		var angle = dist_vector.angle()
		$UI/CanvasLayer/Arrow.rotation = angle - PI
		$PiecesLivesUI/CanvasLayer/Label.text = "Pieces collected: " + str(pieces_collected)
		print(angle)
