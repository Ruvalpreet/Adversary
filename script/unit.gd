class_name Unit extends CharacterBody2D


var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var new_velocity: Vector2;
var moving: bool = true;
var shoot_interval_in_sec: float = 0.1;
var projectiles_array: Array[Area2D];
var projectiles_left: int;
var adversary: Array[String];
var enemy_detection_range: float;
var dead_sprit: Sprite2D;
var unit_live_animation: AnimatedSprite2D;
var path_finding_timer: Timer;

var current_interval:float;
var enemies_in_range: Array[CharacterBody2D];
var active_target: CharacterBody2D;
var reload_timer_node: Timer;
var reloading_speed: float;

#Unit creation function NOTE: NEED TO RUN IN _READY.
func create_unit(unit_type:String, maxHealth: int, damage: int, movement_speed: int, number_of_projectiles_before_reloading: int, projetile: PackedScene, adversary: Array[String], enemy_detection_range: float, enemy_detecation_collision_node: CollisionShape2D, raycasting: RayCast2D, reload_timer_node: Timer, reloading_speed: float, dead_sprit: Sprite2D, unit_live_animation: AnimatedSprite2D, path_finding_timer) -> void:
	if(unit_type == Constants.PLAYER):
		Global.controllable_character.append(self);
	add_to_group(unit_type);
	self.maxHealth = maxHealth;
	self.current_health = maxHealth;
	self.damage = damage;
	self.movement_speed = movement_speed;
	self.adversary = adversary;
	self.enemy_detection_range = enemy_detection_range;
	self.reload_timer_node = reload_timer_node;
	self.reloading_speed = reloading_speed;
	dead_sprit.visible = false;
	self.dead_sprit = dead_sprit;
	self.unit_live_animation = unit_live_animation;
	self.path_finding_timer = path_finding_timer;
	
	enemy_detecation_collision_node.get_shape().radius = enemy_detection_range;
	raycasting.target_position = Vector2(0.0, enemy_detection_range);
	self.projectiles_left = number_of_projectiles_before_reloading - 1;
	for i in number_of_projectiles_before_reloading:
		var bullet: Area2D = projetile.instantiate();
		projectiles_array.append(bullet)
		get_tree().current_scene.add_child.call_deferred(bullet)
	
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
func idle() -> void:
	unit_live_animation.stop();
	unit_live_animation.play(Constants.ANIMATION_IDLE);
	

func enemy_in_area(weapon_animation: Node, raycasting: RayCast2D, raycast_controller: Node2D, delta:float):
	if(active_target && projectiles_left != 0):
		raycast_controller.look_at(active_target.global_position);
		if(raycast_enemy(raycasting)):
			stop_moving_to_shoot(weapon_animation, delta);
		else :
			moving = true;
	else :
		check_for_enemy_priority();
		moving = true
		raycasting.set_enabled(false);
	
	
#NOTE: Need to optimized this
func check_for_enemy_priority() -> bool:
	if(enemies_in_range.is_empty()):
		return false
	if(projectiles_array.is_empty()):
		return false
	if(enemies_in_range.size() == 1):
		active_target = enemies_in_range[0]
		return true
	if(enemies_in_range.size() >= 1):
		active_target = enemies_in_range.pick_random();
		return true
	return false

#NOTE: issue if ray collied with unit that is not an active unit
func raycast_enemy(raycasting:RayCast2D) -> bool:
	raycasting.set_enabled(true);
	if(raycasting.is_colliding()):
		if(raycasting.get_collider() == active_target):
			return true;
			print("just in case if shit happend")
		active_target = null;
		return false
	return false


func stop_moving_to_shoot(weapon_animation: Node2D, delta: float):
	moving = false;
	new_velocity = Vector2.ZERO;
	self.look_at(active_target.global_position);
	if(current_interval >= shoot_interval_in_sec && projectiles_left != 0):
		current_interval = 0.0
		weapon_animation.get_node("AnimatedSprite2D").play(Constants.ANIMATION_SHOOT);
		shoot_single_round()
	
	else:
		current_interval += delta

func shoot_single_round() -> bool:
	var bullet: Area2D = projectiles_array[projectiles_left];
	bullet.transform.origin = global_position;
	bullet.look_at(active_target.global_position);
	var direction = global_transform.x.normalized();
	direction.x = randf_range(direction.x + Constants.PROJECTILE_ANGLE_ERROR, direction.x - Constants.PROJECTILE_ANGLE_ERROR);
	bullet.constructor(direction,enemy_detection_range, damage);
	projectiles_left -= 1;
	if(projectiles_left == 0):
		reload_timer_node.set_wait_time(reloading_speed)
		reload_timer_node.start();
	return true;
		
	
func reload_ammo():
	projectiles_left = projectiles_array.size() - 1;

func damage_take(damage_collision_node: Area2D):
	if(is_zero_approx(current_health)):
		print("character is dead and respan");
		dead()
		current_health = maxHealth;
	if(damage_collision_node.damage):
		damage_collision_node.disable_projectile();
		current_health -= damage_collision_node.damage;
		
func dead():
	Global.GET_DEAD_SHIP_SPRITE(self.global_position);
	queue_free();
	
	#self.set_physics_process(false);
	#self.dead_sprit.visible = true;
	#self.unit_live_animation.stop();
	#self.unit_live_animation.visible = false;
	#self.path_finding_timer.stop();
