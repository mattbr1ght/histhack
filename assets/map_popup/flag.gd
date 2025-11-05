extends Control

var destination: String = ""
var done: bool = false

func _ready() -> void:
	done = false


func _input(event: InputEvent) -> void:
	# Only handle clicks if destination is set and not already done
	if destination != "" and not done:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if get_parent().has_method("goto"):
				get_parent().goto(destination)
			else:
				push_warning("Parent node has no 'goto()' method!")
			done = true
			# If you use a signal system, you could also call:
			# Signalbus.game_node.change_area(destination)


func _on_panel_mouse_entered() -> void:
	if has_meta("display_name"):
		$Label.text = str(get_meta("display_name"))
	if has_meta("destination"):
		destination = str(get_meta("destination"))


func _on_panel_mouse_exited() -> void:
	$Label.text = ""
	destination = ""
	done = false # Reset so it can be clicked again later if needed
