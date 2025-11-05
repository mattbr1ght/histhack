extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player": # or area.is_in_group("player")
		Signalbus.game_node.player.camera.position = Vector2(0, -200)

func _on_area_exited(area: Area2D) -> void:
	if area.name == "Player": # or area.is_in_group("player")
		Signalbus.game_node.player.camera.position = Vector2(0, 0)
