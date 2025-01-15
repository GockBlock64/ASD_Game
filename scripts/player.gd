extends CharacterBody2D


const SPEED = 300.0
var animation = "down"

@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	
	if x_direction != 0 && x_direction >= abs(y_direction):
		animation = "right"
	elif x_direction != 0 && x_direction <= -abs(y_direction):
		animation = "left"
	elif y_direction > abs(x_direction):
		animation = "down"
	elif y_direction < -abs(x_direction):
		animation = "up"
		
	if "idle" not in animation and x_direction == 0 && y_direction == 0:
		animation = "idle_" + animation
	
	animated_sprite.play(animation)

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	
	if x_direction:
		velocity.x = x_direction * SPEED
		print("moving in x")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if y_direction:
		velocity.y = y_direction * SPEED
		print("moving in y")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
