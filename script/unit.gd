class_name Unit extends CharacterBody2D

var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var new_velocity: Vector2;
var moving: bool = true;

#Unit creation function NOTE: NEED TO RUN IN _READY.
func create_unit(unit_type:String, maxHealth: int, damage: int, movement_speed: int) -> void:
	if(unit_type == Constants.PLAYER):
		Global.controllable_character.append(self);
	add_to_group(unit_type);
	self.maxHealth = maxHealth;
	self.current_health = maxHealth;
	self.damage = damage;
	self.movement_speed = movement_speed;
	print(get_groups(), movement_speed);

#to move the unit NOTE: NEED TO SELECT THE DESTINATION FIRST TO DO THE MOVEMENT
func movement() -> void:
	velocity = new_velocity;
	move_and_slide();

# This is to select the location with help of path finding NOTE: MAKE SURE TO RUN IT WITH TIME
# TO AVOID RUNNING PATHFINDING ALGO IN EACH PHYSICS FRAME.
func destination_pathfinding(destination: Vector2, navigationAgent: NavigationAgent2D) -> void:
	if(moving):
		navigationAgent.target_position = destination;
		var next_path = navigationAgent.get_next_path_position();
		look_at(next_path);
		new_velocity = global_position.direction_to(next_path) * self.movement_speed;
		print("the next path", next_path, new_velocity, movement_speed)

#Do things when idle
func idle(idleAnimation:AnimatedSprite2D) -> void:
	idleAnimation.stop();
	idleAnimation.play(Constants.ANIMATION_IDLE);
	

func enemy_in_area(weapon_animation: Node, enemy_unit: Node2D):
	stop_moving_to_shoot()
	look_at(enemy_unit.global_position)
	weapon_animation.get_node("AnimatedSprite2D").play(Constants.ANIMATION_SHOOT)
	return

func stop_moving_to_shoot():
	moving = false;
	new_velocity = Vector2(0,0);
	

func look_at_node_and_check_collision(node:Node2D, raycast: RayCast2D):
	look_at(node.global_position);
	if(raycast.is_colliding()):
		print("colliding");
	
