extends Area2D

signal hit

@export var speed = 200
var screen_size

var ANIM_UP = "up"
var ANIM_DOWN = "down"
var ANIM_LEFT = "left"
var ANIM_RIGHT = "right"
var ANIM_UP_LEFT = "up_left"
var ANIM_UP_RIGHT = "up_right"
var ANIM_DOWN_LEFT = "down_left"
var ANIM_DOWN_RIGHT = "down_right"

var current_animation = ""

func _ready():
	screen_size = get_viewport_rect().size
	
func play_animation(anim_name):
	if current_animation != anim_name:
		$AnimatedSprite2D.play(anim_name)
		current_animation = anim_name

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	match velocity:
		Vector2(0, -1):  # Up
			play_animation(ANIM_UP)
		Vector2(0, 1):  # Down
			play_animation(ANIM_DOWN)
		Vector2(-1, 0):  # Left
			play_animation(ANIM_LEFT)
		Vector2(1, 0):  # Right
			play_animation(ANIM_RIGHT)
		Vector2(-1, -1):  # Up Left
			play_animation(ANIM_UP_LEFT)
		Vector2(1, -1):  # Up Right
			play_animation(ANIM_UP_RIGHT)
		Vector2(-1, 1):  # Down Left
			play_animation(ANIM_DOWN_LEFT)
		Vector2(1, 1):  # Down Right
			play_animation(ANIM_DOWN_RIGHT)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body):
	hide()
	print(body.name)
	if body.is_in_group("mobs"):
		body.catch()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
