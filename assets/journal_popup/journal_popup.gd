extends Control

@onready var title = $Title
@onready var description = $Description
@onready var img = $Image

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_page(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_page(index):
	title.text = StoryManager.journal[index][0]
	img.texture = Signalbus.take_screenshot() # StoryManager.journal[index][1]
	description.text = StoryManager.journal[index][2]