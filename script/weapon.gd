class_name Weapon extends Node2D

var shoot_interval_in_sec: float = 0.2;
const TURN_SPEED: float = 1.95;
const CHECK_FOR_ACTIVE_TARGET: float = 1.0;

var current_shooting_interval:float;

var total_number_of_projectiles: int;
var projectiles_array: Array[Area2D];
var projectiles_left: int;

var reload_timer_node: Timer;
var reloading_speed: float;
var is_reloading: bool;

var projectile_spawn_node: Node2D;
var projectile: PackedScene;
var raycast_enemy: RayCast2D;
var ray_and_shoot_timer: Timer;

var projectile_range: float;
var damage: int;

var enemies_in_range: Array[CharacterBody2D];
var active_target: CharacterBody2D;
var ray_to_find_best_target: RayCast2D;
var check_active_target: Timer;

var enemy_detector_arear_collider: CollisionShape2D;
var shoot_sprite_node : AnimatedSprite2D;

func constructor():
	self.projectiles_left = total_number_of_projectiles - 1;
	raycast_enemy.set_target_position(Vector2(0, projectile_range))
	enemy_detector_arear_collider.shape.radius = projectile_range
	reload_timer_node.set_one_shot(true);
	ray_and_shoot_timer.set_wait_time(shoot_interval_in_sec);
	check_active_target.set_wait_time(CHECK_FOR_ACTIVE_TARGET);
	disable();
	for i in total_number_of_projectiles:
		var bullet: Area2D = projectile.instantiate();
		projectiles_array.append(bullet)
		get_tree().current_scene.add_child.call_deferred(bullet)


func get_active_target():
	if active_target:
		var direction: Vector2 = active_target.global_position - ray_to_find_best_target.global_position
		ray_to_find_best_target.target_position = ray_to_find_best_target.to_local(ray_to_find_best_target.global_position + direction.normalized() * projectile_range);
		ray_to_find_best_target.force_raycast_update()
		if ray_to_find_best_target.is_colliding() and ray_to_find_best_target.get_collider() == active_target:
			return
		else:
			active_target = null
	if enemies_in_range.is_empty():
		return
	
	for enemy in enemies_in_range:
		var direction = enemy.global_position - ray_to_find_best_target.global_position
		ray_to_find_best_target.target_position = ray_to_find_best_target.to_local(ray_to_find_best_target.global_position + direction.normalized() * projectile_range)
		ray_to_find_best_target.force_raycast_update();
		if ray_to_find_best_target.is_colliding() and ray_to_find_best_target.get_collider() == enemy:
			active_target = enemy
			return
	active_target = enemies_in_range[0]


func enemy_in_sight():
	if(raycast_enemy.is_colliding()):
		var collider = raycast_enemy.get_collider()
		if(collider is StaticBody2D):
			return false;
		if(enemies_in_range.has(collider)):
			active_target = raycast_enemy.get_collider();
			return shoot_single_round();
		return false;
	else:
		return false;

func shoot_single_round():
	if(is_reloading):
		return
	var bullet: Area2D = projectiles_array[projectiles_left];
	bullet.transform.origin = projectile_spawn_node.global_position;
	
	bullet.set_global_rotation(global_rotation);
	var direction = global_transform.x;
	direction.x = randf_range(direction.x + Constants.PROJECTILE_ANGLE_ERROR, direction.x - Constants.PROJECTILE_ANGLE_ERROR);
	direction.y = randf_range(direction.y + Constants.PROJECTILE_ANGLE_ERROR, direction.y - Constants.PROJECTILE_ANGLE_ERROR);
	shoot_sprite_node.play(Constants.ANIMATION_SHOOT)
	bullet.constructor(direction,projectile_range, damage);
	projectiles_left -= 1;
	if(projectiles_left <= 0):
		is_reloading = true
		reload_timer_node.set_wait_time(reloading_speed)
		reload_timer_node.start();

func reload_ammo():
	projectiles_left = total_number_of_projectiles - 1;
	is_reloading = false;
	
func disable():
	set_physics_process(false);
	ray_and_shoot_timer.stop();
	check_active_target.stop();
	
func enable():
	set_physics_process(true);
	ray_and_shoot_timer.start();
	check_active_target.start();
	
func look_at_active_target(delta:float):
	if(active_target):
		var direction = (active_target.global_position - global_position).angle();
		global_rotation = lerp_angle(global_rotation, direction, TURN_SPEED * delta);

func get_data_from_parent(heath_ration: float):
	shoot_sprite_node.set_self_modulate(Color(heath_ration,heath_ration,heath_ration))
	
func look_at_mouse_target(delta:float):
	var direction = (get_global_mouse_position() - global_position).angle();
	global_rotation = lerp_angle(global_rotation, direction, TURN_SPEED * delta);
	
