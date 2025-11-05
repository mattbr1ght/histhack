extends Area2D

@onready var collectible_name = get_meta("collectible_name")
@onready var dialogue_line = get_meta("dialogue_line")
@onready var quest_id = get_meta("quest_name")
var active: bool = false

signal done

func interact():
	if active:
		return
	Signalbus.radio_frequency = load("res://scripts/minigames/radio_frequency/radio_frequency.tscn").instantiate()
	print(Signalbus.radio_frequency)
	Signalbus.player.ui.add_child(Signalbus.radio_frequency)
	active = true
	tooltip_disable()
	await Signalbus.radio_frequency.done
	Signalbus.radio_frequency.queue_free()
	await Signalbus.game_node.dialogue_item.display_dialog(dialogue_line)
	if !QuestManager.has_quest(quest_id):
		Signalbus.game_node.dialogue_item.display_dialog("cannot-complete-quest-yet")	
		return
	QuestManager.finish_quest(quest_id)	
	done.emit()
	queue_free()
	pass
	
func tooltip_enable():
	if active:
		return
	Signalbus.tooltip_show(collectible_name + "\n Nacisnij [F] aby wejsc w interakcje", self)
	pass
	
func tooltip_disable():
	Signalbus.tooltip_hide()
	pass
