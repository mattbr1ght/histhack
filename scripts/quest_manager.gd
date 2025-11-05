extends Node

var quest_text: RichTextLabel
var current_quests = [{"name": "Zdobadz dame z gronotajem", "id": "dama_z_gronostajem_found"}, {"name": "Odblokuj sejf z dama z gronostajem", "id": "dama_z_gronostajem_unlocked"}]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func has_quest(quest_id:  String) -> bool:
	return !current_quests.filter(func(quest): return quest.id == quest_id).is_empty()

func render():
	if quest_text == null:
		return
	var res = ""
	for quest in current_quests:
		res += "[ ] " + quest.name + "\n"
	quest_text.text = res
	
func finish_quest(quest_id):
	current_quests = current_quests.filter(func(quest): return quest.id != quest_id)
	self.render()
