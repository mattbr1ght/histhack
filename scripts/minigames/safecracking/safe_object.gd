extends Area2D

@onready var collectible_name = get_meta("collectible_name")
var dialogue_line = get_meta("dialogue_line")
var quest_id = get_meta("quest_name")

signal done

func interact():
	Signalbus.safe_cracking = load("res://scripts/minigames/safecracking/SafeCracking.tscn").instantiate()
	print(Signalbus.safe_cracking)
	%CanvasLayer.add_child(Signalbus.safe_cracking)
	await Signalbus.safe_cracking.done
	Signalbus.safe_cracking.queue_free()
	await Signalbus.game_node.dialogue_item.display_dialog(dialogue_line)
	if !QuestManager.has_quest(quest_id):
		Signalbus.game_node.dialogue_item.display_dialog("cannot-complete-quest-yet")	
		return
	QuestManager.finish_quest(quest_id)	
	done.emit()
	queue_free()
	pass
	
func tooltip_enable():
	Signalbus.tooltip_show(collectible_name + "\n Nacisnij [F] aby wejsc w interakcje", self)
	pass
	
func tooltip_disable():
	Signalbus.tooltip_hide()
	pass
