extends Sprite2D

var rotation_speed = 5.0

func _process(delta):
	var target_angle = (get_global_mouse_position() - global_position).angle()
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
