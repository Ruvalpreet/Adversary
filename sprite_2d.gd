extends Sprite2D


func _process(delta: float) -> void:
	position = get_global_mouse_position()
	self.z_index = position.y/10
	$"../Icon".z_index = $"../Icon".global_position.y/10
	
