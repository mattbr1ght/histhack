extends Control

@onready var scene_text_file = "res://dialogues.json"

var dialogues
var selected_text = []
var in_progress = false
var temporary_solution = 0

@onready var text_label = $HBoxContainer/Control/Label

signal skip_input

func _ready():
	dialogues = load_dialogues()

func _input(event):
	if (in_progress):
		if (Input.is_action_just_pressed("skip")):
			if (OS.get_name() == "Android" and temporary_solution == 0):
				temporary_solution = 1
				return
			temporary_solution = 0
			if text_label.visible_characters >= text_label.text.length():
				skip_input.emit()
			else:
				text_label.show_full()

func load_dialogues():
		var file = FileAccess.open("res://dialogues.json", FileAccess.READ)
		var json = JSON.new()
		json.parse(file.get_as_text())
		return json.data

func show_text():
	text_label.text = selected_text # .pop_front()
	text_label.start_typing()
	

func finish():
	text_label.text = ""
	in_progress = false
	get_tree().paused = false
	
func display_dialog(text_key, dialogue_category = null):
	if !dialogues.has(text_key):
		return
	var current_dialogues = dialogues
	finish()
	Signalbus.tooltip_hide()

	if (dialogue_category != null):
		current_dialogues = dialogue_category
	
	for text in current_dialogues[str(text_key)]:
		get_tree().paused = true

		#Signalbus.player.camera.pasue_mode = false
	
		in_progress = true
		selected_text = text
		show_text()
		await skip_input
	
	finish()

	return
