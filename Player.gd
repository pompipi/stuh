extends Area2D

var levels = [	"star",
				"turtle",
				"bus",
				"motorbike",
				"plane",
				"helicopter",
				"lion",
				"giraffe"]
			
var _current_level = 0
var _level_small_image = {}

var bursting = false

func _init():
	for i in levels:
		_level_small_image[i] = load("res://assets/" + i + "/" + i + "_small.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("input_event", self, "_on_character_touched")
	$AnimatedSprite.animation = levels[_current_level]
	$Particles2D.hide()
	

func _on_character_touched(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed() and !bursting:
			run()
	
func run():
	bursting = true
	
	$SoundClicked.play()
	show_burst()
	yield(get_tree().create_timer(4.0), "timeout")
	load_next_level()
	show_clickable()
		
	bursting = false

func load_next_level():
	var next_level
	
	if _current_level < levels.size() - 1:
		next_level = _current_level + 1
	else:
		next_level = 0
	
	$Particles2D.set_texture(_level_small_image[levels[next_level]])
	$AnimatedSprite.animation = levels[next_level]
	
	_current_level = next_level
	print(_current_level)
	
func show_clickable():
	$AnimatedSprite.show()
	$Particles2D.hide()

func show_burst():
	$AnimatedSprite.hide()
	$Particles2D.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
