extends Area2D

var shootcooldown = false

func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && shootcooldown == true:
		shoot()
		shootcooldown = false

func shoot():
	const BULLET = preload("res://bullet.tscn")
	const BULLET_COUNT = 5  # Number of bullets to shoot (spread)
	const SPREAD_ANGLE = deg_to_rad(10)  # Spread angle in radians (adjust as needed)
	for i in range(BULLET_COUNT):
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		# Calculate a random spread by slightly rotating each bullet
		var spread = randf_range(-SPREAD_ANGLE, SPREAD_ANGLE)
		new_bullet.global_rotation = %ShootingPoint.global_rotation + spread
		# Add the bullet to the scene
		%ShootingPoint.add_child(new_bullet)



func _on_timer_timeout() -> void:
	shootcooldown = true
	$Timer.start()