extends Control

@export var target_freq := 50.0
@export var tolerance := 3.0
@export var difficulty := 0.3 # how fast signal drops off when off-tune
@export var tune_speed := 60.0 # slider auto drift speed (if you want chaos)
@export var auto_drift := false

var active := true

func _ready():
	randomize()
	target_freq = randf_range(20, 80)
	$FrequencySlider.min_value = 0
	$FrequencySlider.max_value = 100
	$StatusLabel.text = "Find the right frequency..."
	$SignalStrength.value = 0


func _process(delta):
	if !active:
		return

	if auto_drift:
		$FrequencySlider.value = clampf($FrequencySlider.value + sin(Time.get_ticks_msec() / 300.0) * delta * tune_speed, 0, 100)

	var dist = abs($FrequencySlider.value - target_freq)
	var sig = max(0.0, 100.0 - dist * (10.0 * difficulty))
	$SignalStrength.value = lerp(ceil($SignalStrength.value), sig, 0.1)

	if Input.is_action_just_pressed("ui_accept"):
		check_success(dist)


func check_success(dist: float):
	if dist <= tolerance:
		$StatusLabel.text = "✅ Transmission clear!"
	else:
		$StatusLabel.text = "❌ Interference too strong!"
	active = false
	await get_tree().create_timer(1.5).timeout
	start_new_round()


func start_new_round():
	target_freq = randf_range(20, 80)
	$StatusLabel.text = "Next code incoming..."
	active = true
