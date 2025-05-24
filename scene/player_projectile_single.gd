extends Projectiles

var lifetime = 2.0  # seconds

var direction = Vector2.ZERO
var speed = 400  # pixels per second

func set_direction(dir: Vector2):
	direction = dir.normalized()

func _physics_process(delta: float) -> void:
	if(direction):
		lifetime -= delta
		if lifetime <= 0:
			queue_free()
		position += direction * speed * delta
