class_name Projectiles extends Area2D


var lifetime: float = 2.0
var direction: Vector2 = Vector2.ZERO
var speed:int;
var start_position:Vector2
var max_distance: float; 

func constructor(lifetime: float, direction: Vector2, max_distance: float):
	self.lifetime = lifetime;
	self.direction = direction.normalized();
	self.speed = Constants.PROJECTILE_VELOCITY;
	self.max_distance = max_distance
	self.start_position = self.global_position;
	if(!self.is_physics_processing()):
		set_physics_process(true);

func start(delta: float):
	if(cal_distance_travel(start_position, self.position) >= max_distance):
		print("bullet reached:", max_distance);
		set_physics_process(false);
		queue_free()
	position += direction * speed * delta

func cal_distance_travel(initial_position: Vector2, current_position: Vector2) -> float:
	return initial_position.distance_to(current_position);
