extends Area2D

@onready var collectible_name = get_meta("collectible_name")

signal done

func interact():
	await Signalbus.game_node.dialogue_item.display_dialog("time_machine_1")
	done.emit()
	# queue_free()
	pass
	
func tooltip_enable():
	Signalbus.tooltip_show(collectible_name + "\n Nacisnij [F] aby wejsc w interakcje", self)
	pass
	
func tooltip_disable():
	Signalbus.tooltip_hide()
	pass
