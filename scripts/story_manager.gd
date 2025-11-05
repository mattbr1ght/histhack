extends Node

var current_stage = ""
var game
@onready var intro_panel = load("res://assets/panels/intro_panel/panel.tscn")
@onready var intro_panel1 = load("res://assets/panels/intro_panel/panel1.tscn")
@onready var map_popup = load("res://assets/map_popup/map_popup.tscn")
@onready var journal_popup = load("res://assets/journal_popup/journal_popup.tscn")
var saski_palace_zoom_enabled = false

signal saski_after_time_travel
var journal = [["Dziennik zaginionych dzieł i zabytków", null, ""]] # [title, img, desc]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if saski_palace_zoom_enabled:
		var zoom = clamp(
	(10 - abs(1 - abs(Signalbus.game_node.player.position.y / 128.0)) * 1.35),
	0.65,
	1.50
)

		print(zoom)
		Signalbus.game_node.player.camera.zoom = Vector2(zoom, zoom)


func start():
	game = Signalbus.game_node
	advance("intro")
	pass
func advance(stage):
	match stage:
		"intro":
			stage_intro()
		"map_first":
			stage_map_first()
		"saski_palace":
			stage_saski_palace()

func stage_intro():
	Signalbus.fade.fade_in()
	var intro_panel_ins = intro_panel.instantiate()

	game.canvas_layer.add_child(intro_panel_ins)
	await game.dialogue_item.display_dialog("arcana_intro_part_1")
	await Signalbus.fade.fade_out()

	intro_panel_ins.queue_free()
	intro_panel_ins = intro_panel1.instantiate()
	game.canvas_layer.add_child(intro_panel_ins)

	Signalbus.fade.fade_in()

	await game.dialogue_item.display_dialog("arcana_intro_part_2")
	await Signalbus.fade.fade_out()
	intro_panel_ins.queue_free()
	Signalbus.fade.fade_in()
	
	advance("map_first")
	pass

func stage_map_first():
	var map_popup_ins = map_popup.instantiate()
	game.canvas_layer.add_child(map_popup_ins)
	await map_popup_ins.get_node("Syrenka").display_dialog("syrenka_1")
	await map_popup_ins.done
	await Signalbus.fade.fade_out()
	map_popup_ins.queue_free()
	Signalbus.fade.fade_in()

func stage_saski_palace():
	var time_machine = Signalbus.game_node.current_area.get_node("TimeMachine/Area2D")
	await time_machine.done
	await Signalbus.fade.fade_out()
	saski_palace_zoom_enabled = true
	#Signalbus.game_node.current_area.get_node("Barrier").queue_free()
	await get_tree().create_timer(1.0).timeout
	Signalbus.fade.fade_in()
	saski_after_time_travel.emit()
	Signalbus.player.toggle_old_filter()
	#Signalbus.game_node.player.toggle_old_filter()
	pass
