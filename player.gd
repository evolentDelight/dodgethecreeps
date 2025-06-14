extends Area2D

signal hit

@export var speed = 400#pixels/sec | How fast the player will move (pixels/sec)
var screen_size # Size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide() #Hides the Player Node Type: Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var velocity = Vector2.ZERO # The player's movement vector
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) #position.clamp(,) is to prevent the player unit from leaving the screen

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		#$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(_body: Node2D):
	hide() # Player disappears after being hit
	hit.emit()
	
	$CollisionShape2D.set_deferred("disabled", true) # Must be deferred because we can't change physics properties on a physics callback
		#This is to disable the player's collision so that we don't trigger the <hit> signal more than once.

func start(pos): #Function to reset the player when starting a new game
	position = pos
	show()
	$CollisionShape2D.disabled = false
