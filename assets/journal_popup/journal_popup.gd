extends Control

@onready var title = $Title
@onready var description = $Description
@onready var img = $Image
var current_page = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_page(current_page)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_page(index):
	title.text = StoryManager.journal[index][0]
	img.texture = StoryManager.journal[index][1] # StoryManager.journal[index][1]
	description.text = StoryManager.journal[index][2]


func _on_next_pressed() -> void:
	if (current_page < len(StoryManager.journal)):
		current_page += 1
		display_page(current_page)
	pass # Replace with function body.


func _on_prev_pressed() -> void:
	if (current_page > len(StoryManager.journal)):
		current_page -= 1
		display_page(current_page)
	pass # Replace with function body.


func _on_close_pressed() -> void:
	Signalbus.game_node.player.ui.get_node("Journal").visible = true
	queue_free()
	pass # Replace with function body.
