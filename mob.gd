extends RigidBody2D

func _ready():
	$AnimatedSprite2D.play("pokeball_rolling")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _physics_process(delta):
	pass

func catch():
	$AnimatedSprite2D.stop()  
	linear_velocity = Vector2.ZERO 
	rotate_until_zero()
	$AnimatedSprite2D.play("catch")  
	
func rotate_until_zero():
	while abs(rotation) > 0.01:
		angular_velocity = abs(rotation)*5
		await get_tree().create_timer(0.1).timeout
	

