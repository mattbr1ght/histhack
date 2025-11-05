extends Label

var typing_speed = 20
var current_char_count = 0
var is_typing = false

func _ready():
	start_typing()

func show_full():
	self.visible_characters = self.text.length()
	is_typing = false
	current_char_count = 0

func start_typing():
	is_typing = true
	self.visible_characters = 0
	current_char_count = 0

func _process(delta):
	if is_typing:
		current_char_count += typing_speed * delta
		if current_char_count >= text.length():
			visible_characters = text.length()
			is_typing = false
		else:
			visible_characters = int(current_char_count)
