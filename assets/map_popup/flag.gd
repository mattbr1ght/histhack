extends Control

var destination = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (destination != ""):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_parent().goto(destination)
			# Signalbus.game_node.change_area(destination)
		

func _on_panel_mouse_entered() -> void:
	$Label.text = get_meta("display_name")
	destination = get_meta("destination")
	pass # Replace with function body.


func _on_panel_mouse_exited() -> void:
	$Label.text = ""
	destination = ""
	pass # Replace with function body.
