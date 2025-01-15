extends Node2D

func pause():
	get_tree().paused = true
	$PauseMenu.show()

func unpause():
	$PauseMenu.hide()
	get_tree().paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
