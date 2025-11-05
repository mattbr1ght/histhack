extends Control

@export var min_value := 2.5
@export var max_value := 97.5
@export var marker_width := 10.0
@export var move_speed := 600.0 # pixels per second
@export var tolerance := 5.0    # how close to marker counts as success

var reverse := false
var running := false
var marker_pos := 0.0

signal done

func _ready() -> void:
	randomize()
	$slider.min_value = min_value
	$slider.max_value = max_value
	start_round()


func start_round() -> void:
	running = true
	reverse = false
	marker_pos = randf_range(min_value + 10, max_value - 10)
	
	var slider := $slider
	var slider_width = slider.size.x
	var rel_start = (marker_pos - min_value) / (max_value - min_value)
	var rel_width = marker_width / float(max_value - min_value)
	
	$marker.size.x = slider_width * rel_width
	$marker.position.x = slider.position.x + slider_width * rel_start - ($marker.size.x/2)
	$marker.visible = true
	$slider.value = min_value


func _process(delta: float) -> void:
	if !running:
		return

	var step = delta * move_speed / ($slider.size.x / (max_value - min_value))
	#print(step)
	#print($slider.value)
	if reverse:
		$slider.value -= step
	else:
		$slider.value += step

	if $slider.value >= max_value:
		reverse = true
	elif $slider.value <= min_value:
		reverse = false

	# handle space press
	if Input.is_action_just_pressed("ui_accept"): # SPACE by default
		check_hit()


func check_hit() -> void:
	running = false
	var val = $slider.value
	if abs(val - marker_pos) <= tolerance:
		done.emit()
		show_result(true)
	else:
		show_result(false)


func show_result(success: bool) -> void:
	if success:
		print("Hit")
	else:
		print("Missed. Marker was at %.2f, you clicked at %.2f." % [marker_pos, $slider.value])
	
	await get_tree().create_timer(1.0).timeout
	start_round()
