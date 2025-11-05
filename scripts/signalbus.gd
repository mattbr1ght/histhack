extends Node

var game_node
var player
var tt_item
var tt_state = false
var scene_root
var fade = load("res://assets/fade/fade.tscn")
var scenes = {
	"mokotow": [load("res://assets/map/mokotow.tscn")],
	"saski_palace": [load("res://assets/map/saski_palace.tscn")]
}

var safe_cracking: Node
var timing_bar: Node
var radio_frequency: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scene_root = get_parent()
	fade = fade.instantiate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func tooltip_show(tooltip, area):
	if (tt_state == false):
		tt_state = true
		tt_item = load("res://assets/dialogue/dialogue_item.tscn").instantiate()
		area.add_child(tt_item)
		tt_item.get_node("text").text = tooltip
	
func tooltip_hide():
	if (tt_item != null):
		tt_item.queue_free()
		tt_state = false

func take_screenshot():
	var img = get_viewport().get_texture().get_image()
	return ImageTexture.create_from_image(img)

func add_journal(title, description):
	StoryManager.journal.append([title, take_screenshot(), description])