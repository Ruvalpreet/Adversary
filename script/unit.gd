class_name Unit extends CharacterBody2D

var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var new_velocity: Vector2;
var stop_moving: bool = false;

var unitType: GlobalConstant.UNITTYPE;

#to move the unit NOTE: NEED TO SELECT THE DESTINATION FIRST TO DO THE MOVEMENT
func movement() -> void:
	velocity = new_velocity;
	move_and_slide();

# This is to select the location with help of path finding NOTE: MAKE SURE TO RUN IT WITH TIME
# TO AVOID RUNNING PATHFINDING ALGO IN EACH PHYSICS FRAME.
func destination_pathfinding(destination: Vector2, navigationAgent: NavigationAgent2D) -> void:
	if(!stop_moving):
		navigationAgent.target_position = destination;
		var next_path = navigationAgent.get_next_path_position();
		look_at(next_path);
		print("the next path", next_path)
		new_velocity = global_position.direction_to(next_path) * movement_speed;

#Do things when idle
func idle(idleAnimation:AnimatedSprite2D, name:StringName) -> void:
	idleAnimation.stop();
	idleAnimation.play(name);
	

func enemy_in_area():
	return

func look_at_node_and_check_collision(node:Node2D, raycast: RayCast2D):
	look_at(node.global_position);
	if(raycast.is_colliding()):
		print("colliding");
	
