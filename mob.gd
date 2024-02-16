extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("pokeball_rolling")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func catch():
	linear_velocity = Vector2.ZERO
	rotation = 0
	$AnimatedSprite2D.play("catch")
