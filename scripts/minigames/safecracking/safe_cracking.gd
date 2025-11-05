extends Control

@export var lock_count := 3
@export var tolerance := 6.0
@export var rotation_speed := 100.0

var current_lock := 0
var target_angle := 0.0
var success := false

signal done

func _ready():
	await get_tree().create_timer(1.0).timeout
	reset_lock()


func _process(delta):
	if success:
		return
	$Dial.rotation_degrees += rotation_speed * delta
	if $Dial.rotation_degrees > 360: 
		$Dial.rotation_degrees -= 360
		
		
	var diff = absf(wrapf($Dial.rotation_degrees - target_angle, -180, 180))
	if diff <= tolerance:
		$Status.text = "Ciepło"
	else:
		$Status.text = "Zimno"
	

	if Input.is_action_just_pressed("ui_accept"):
		if diff <= tolerance:
			current_lock += 1
			$Status.text = "Cyk! Pin %d odblokowany" % [current_lock]
			$LockProgress.value = float(current_lock) / lock_count * 100.0
			if current_lock >= lock_count:
				unlock_safe()
			else:
				reset_lock()
		else:
			$Status.text = "Bład"
			current_lock = 0
			$LockProgress.value = 0
			await get_tree().create_timer(0.7).timeout
			reset_lock()


func reset_lock():
	target_angle = randf_range(0, 360)


func unlock_safe():
	success = true
	await get_tree().create_timer(0.5).timeout
	$Status.text = "Sejf otwarty"
	done.emit()
	await get_tree().create_timer(2.0).timeout
	success = false
	current_lock = 0
	reset_lock()
	$Status.text = "Sejf zablokowany"
	$LockProgress.value = 0
