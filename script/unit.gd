class_name Unit extends CharacterBody2D

var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var new_velocity: Vector2;
var moving: bool = true;
var projectile_velocity:int;
var shoot_interval_in_sec: float = 0.5;
var projectiles_array: Array[Area2D];

var current_interval:float;
var enemies_in_range: Array[CharacterBody2D];
var active_target: CharacterBody2D;

#Unit creation function NOTE: NEED TO RUN IN _READY.
func create_unit(unit_type:String, maxHealth: int, damage: int, movement_speed: int, projectile_velocity: int, number_of_projectiles_before_loading: int, projetile: PackedScene) -> void:
	if(unit_type == Constants.PLAYER):
		Global.controllable_character.append(self);
	add_to_group(unit_type);
	self.maxHealth = maxHealth;
	self.current_health = maxHealth;
	self.damage = damage;
	self.movement_speed = movement_speed;
	self.projectile_velocity = projectile_velocity;
	for i in number_of_projectiles_before_loading:
		var bullet: Area2D = projetile.instantiate();
		projectiles_array.append(bullet)
	print("intital data",get_groups(), projectiles_array.size());

#to move the unit NOTE: NEED TO SELECT THE DESTINATION FIRST TO DO THE MOVEMENT
func movement(delta: float) -> void:
	velocity = new_velocity * delta;
	move_and_slide();

# This is to select the location with help of path finding NOTE: MAKE SURE TO RUN IT WITH TIME
# TO AVOID RUNNING PATHFINDING ALGO IN EACH PHYSICS FRAME.
func destination_pathfinding(destination: Vector2, navigationAgent: NavigationAgent2D) -> void:
	if(moving):
		navigationAgent.target_position = destination;
		var next_path = navigationAgent.get_next_path_position();
		look_at(next_path);
		new_velocity = global_position.direction_to(next_path) * self.movement_speed;

#Do things when idle
func idle(idleAnimation:AnimatedSprite2D) -> void:
	idleAnimation.stop();
	idleAnimation.play(Constants.ANIMATION_IDLE);
	

func enemy_in_area(weapon_animation: Node, projetile: PackedScene, raycasting: RayCast2D, raycast_controller: Node2D, delta:float):
	if(check_for_enemy_priority() && active_target):
		raycast_controller.look_at(active_target.global_position);
		if(raycast_enemy(raycasting)):
			stop_moving_to_shoot(weapon_animation, projetile, delta);
		else :
			moving = true;
	else :
		raycasting.set_enabled(false)
	
	

func check_for_enemy_priority() -> bool:
	if(enemies_in_range.is_empty()):
		return false
	if(enemies_in_range.size() == 1):
		active_target = enemies_in_range[0]
		return true
	if(enemies_in_range.size() >= 1):
		active_target = enemies_in_range.pick_random();
		return true
	return false

func raycast_enemy(raycasting:RayCast2D) -> bool:
	raycasting.set_enabled(true);
	if(raycasting.is_colliding()):
		raycasting.get_collider().is_in_group(Constants.ENEMY);
		return true;
	return false


func shoot_single_round() -> bool:
	if(projectiles_array.is_empty()):
		reload_ammo()
		return false
	var bullet: Area2D = projectiles_array[0];
	print("bullet count", bullet)
	bullet.transform.origin = global_position;
	bullet.look_at(active_target.global_position)
	var direction = global_transform.x.normalized();
	bullet.set_direction(direction);
	get_tree().current_scene.add_child(bullet)
	projectiles_array.remove_at(0)
	print("how many bullets left", projectiles_array)
	return true;
		
	
func reload_ammo():
	pass


func stop_moving_to_shoot(weapon_animation: Node2D, projectile: PackedScene, delta: float):
	moving = false;
	new_velocity = Vector2(0,0);
	self.look_at(active_target.global_position);
	if(current_interval >= shoot_interval_in_sec && !projectiles_array.is_empty()):
		current_interval = 0.0
		weapon_animation.get_node("AnimatedSprite2D").play(Constants.ANIMATION_SHOOT);
		shoot_single_round()
	
	else:
		#weapon_animation.get_node("AnimatedSprite2D").stop();
		current_interval += delta
	

func look_at_node_and_check_collision(node:Node2D, raycast: RayCast2D):
	look_at(node.global_position);
	if(raycast.is_colliding()):
		print("colliding");
	
