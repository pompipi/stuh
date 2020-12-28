extends Area2D

var playerSprite = "star"
var imageSmallTurtle = load("res://assets/turtle/turtle_small.png")
var imageSmallStar = load("res://assets/star/star_small.png")
var imageSmallBus = load("res://assets/bus/bus_small.png")
var imageSmallMotorbike = load("res://assets/motorbike/motorbike _small.png")
var bursting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("input_event", self, "_on_character_touched")
	$AnimatedSprite.animation = playerSprite
	$Particles2D.hide()

func _on_character_touched(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed() and !bursting:
			run()
	
func run():
	bursting = true
	print("click")
	$SoundClicked.play()
		
	showBurst()

	yield(get_tree().create_timer(4.0), "timeout")
	
	if playerSprite == "star":
		playerSprite = "turtle"
		$Particles2D.set_texture(imageSmallTurtle)
	elif playerSprite == "turtle":
		playerSprite = "bus"
		$Particles2D.set_texture(imageSmallBus)
	elif playerSprite == "bus":
		playerSprite = "motorbike"
		$Particles2D.set_texture(imageSmallMotorbike)
	else:
		playerSprite = "star"
		$Particles2D.set_texture(imageSmallStar)
	$AnimatedSprite.animation = playerSprite
	
	showClickable()
		
	bursting = false
	
func showClickable():
	$AnimatedSprite.show()
	$Particles2D.hide()

func showBurst():
	$AnimatedSprite.hide()
	$Particles2D.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
