extends Node2D

func pause():
	get_node("UI/CanvasLayer").hide()
	get_node("ColorRect").color = "00000099";
	get_tree().paused = true
	get_node("PauseMenu/CanvasLayer").show()

func unpause():
	get_node("PauseMenu/CanvasLayer").hide()
	get_tree().paused = false
	get_node("UI/CanvasLayer").show()
	get_node("ColorRect").color = "00000000";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("PauseMenu/CanvasLayer").hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
