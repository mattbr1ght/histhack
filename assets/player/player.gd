extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var old_effect = $Camera2D/Control/CanvasLayer/OldTimeyEffect
@onready var speed: float = 175.0
@onready var base_zoom: Vector2 = Vector2(2, 2)
@onready var is_map_open: bool = false
@onready var is_windows: bool = true
@onready var joystick = null # Assign in _ready() if needed
@onready var interact_button = null
@onready var last_pos: Vector2 = Vector2.ZERO
@onready var is_old_filter_on = false
@onready var ui = %CanvasLayer

# Movement input axes
var move_input: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Uncomment and adjust if joystick & interact_button exist in scene
	# joystick = $Camera2D/Control/CanvasLayer/Joystick
	# interact_button = $Camera2D/Control/CanvasLayer/InteractButton
	Signalbus.player = self
	camera.zoom = base_zoom
	QuestManager.quest_text = $Camera2D/Control/CanvasLayer/quests
	QuestManager.render()
	# $Camera2D/Control/CanvasLayer/quests
	last_pos = position


func _physics_process(delta: float) -> void:
	# Handle movement input
	if not is_map_open:
		if is_windows:
			move_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		elif joystick:
			move_input = joystick.posVector
		else:
			move_input = Vector2.ZERO
	else:
		move_input = Vector2.ZERO

	# Apply movement
	velocity = move_input * speed
	move_and_slide()

	# Handle animation
	_handle_animation()

	# Play footsteps when moving
	if position.distance_to(last_pos) > 1.0:
		if $Timer.time_left <= 0:
			$footstep_a.pitch_scale = randf_range(0.8, 1.2)
			$footstep_a.play()
			$Timer.start(0.25)
	else:
		animated_sprite.play("idle")

	last_pos = position

	# Smooth zoom interpolation
	#camera.zoom = camera.zoom.lerp(zoom, delta * 4.0)


func _handle_animation() -> void:
	if move_input.x != 0:
		animated_sprite.scale.x = sign(move_input.x)
		animated_sprite.play("w_side")
	elif move_input.y < 0:
		animated_sprite.play("w_back")
	elif move_input.y > 0:
		animated_sprite.play("w_front")
	else:
		animated_sprite.play("idle")


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and $Player.has_overlapping_areas():
		var areas = $Player.get_overlapping_areas()
		for area in areas:
			if "interact" in area:
				area.interact()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if "tooltip_enable" in area:
		area.tooltip_enable()


func _on_area_2d_area_shape_exited(area_rid, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area and "tooltip_disable" in area:
		area.tooltip_disable()

func toggle_old_filter() -> void:
	old_effect.visible = !is_old_filter_on


func _on_journal_pressed() -> void:
	Signalbus.game_node.canvas_layer.add_child(StoryManager.journal_popup.instantiate())
	self.visible = false
	pass # Replace with function body.
