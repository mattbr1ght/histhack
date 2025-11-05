extends Control


signal done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func goto(destination):
	Signalbus.game_node.change_area(destination)
	StoryManager.advance(destination)
	done.emit()
