class_name Unit extends CharacterBody2D

var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var current_position: Vector2;
var new_velocity: Vector2;

var unitType: GlobalConstant.UNITTYPE;

func walk_to():
	velocity = new_velocity;
	move_and_slide();

func on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func limited_run_pathfinding(destination: Vector2, navigationAgent: NavigationAgent2D) -> void:
	if(destination && navigationAgent):
		navigationAgent.target_position = destination;
		current_position = global_position;
		var next_path = navigationAgent.get_next_path_position();
		print("the next path", next_path)
		new_velocity = current_position.direction_to(next_path) * movement_speed;


func look_at_node_and_check_collision(node:Node2D, raycast: RayCast2D):
	look_at(node.global_position);
	if(raycast.is_colliding()):
		print("colliding");
	
