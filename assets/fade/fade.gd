extends ColorRect

@onready var anim_player = get_node("AnimationPlayer")

func fade_in():
	anim_player.play("fade_in")
	await get_tree().create_timer(0.4).timeout

func fade_out():
	anim_player.play("fade_out")
	await get_tree().create_timer(0.4).timeout
