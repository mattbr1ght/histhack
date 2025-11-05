extends Node2D

@onready var dialogue_item = load("res://assets/dialogue/dialogue_item.tscn")
var current_area
var player
var canvas_layer
var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signalbus.game_node = self
	dialogue_item = dialogue_item.instantiate()
	player = $Player
	canvas_layer = player.get_node("./Camera2D/Control/CanvasLayer")
	canvas_layer.add_child(dialogue_item)
	canvas_layer.add_child(Signalbus.fade)
	StoryManager.start()
	pass # Replace with function body.


func change_area(new_area) -> void:
	new_area = Signalbus.scenes[new_area]
	current_area = new_area[0].instantiate()
	if self.current_area != null:
		self.remove_child(self.current_area)
	self.add_child(current_area)
