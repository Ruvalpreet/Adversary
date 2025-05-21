extends Unit

var mouse_position: Vector2;

func _ready() -> void:
	movement_speed = 50;
	mouse_position = get_global_mouse_position();
	return;
	
func _physics_process(delta: float) -> void:
	walk_to()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	on_navigation_agent_2d_velocity_computed(safe_velocity);


func _on_timer_timeout() -> void:
	mouse_position = get_global_mouse_position();
	limited_run_pathfinding(mouse_position, $NavigationAgent2D);
