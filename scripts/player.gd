extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	if x_direction and y_direction:
		var inv_magnitude = pow(x_direction * x_direction + y_direction * y_direction, -0.5)
		x_direction *= inv_magnitude
		y_direction *= inv_magnitude
	
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
