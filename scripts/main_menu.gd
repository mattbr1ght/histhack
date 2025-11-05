extends Control


# # Called when the node enters the scene tree for the first time.
# func _ready() -> void:
# 	pass # Replace with function body.
#
#
# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass

func _on_play_pressed() -> void:
	# var playspace = preload('res://scenes/game.tscn')
	get_tree().change_scene_to_file('res://scenes/game.tscn')
	# var _instance = playspace.instantiate()
	# get_tree().root.add_child(_instance)


func _on_options_pressed() -> void:
	var options = preload('res://scenes/options.tscn')
	var _instance = options.instantiate()
	get_tree().root.add_child(_instance)

func _on_exit_pressed() -> void:
	get_tree().quit()
