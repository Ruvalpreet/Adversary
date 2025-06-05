class_name Weapon extends Node2D

const shoot_interval_in_sec: float = 0.1;
const TURN_SPEED = 2.95

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

var projectile_range: float;
var damage: int;

var enemies_in_range: Array[CharacterBody2D];
var active_target: CharacterBody2D;

var sprite_node : AnimatedSprite2D;

func constructor():
	self.projectiles_left = total_number_of_projectiles - 1;
	disable();
	for i in total_number_of_projectiles:
		var bullet: Area2D = projectile.instantiate();
		projectiles_array.append(bullet)
		get_tree().current_scene.add_child.call_deferred(bullet)


func get_active_target():
	if(!enemies_in_range.is_empty()):
		active_target = enemies_in_range[0];

func enemy_in_sight():
	if(raycast_enemy.is_colliding()):
		var collider = raycast_enemy.get_collider()
		if(collider is StaticBody2D):
			return false;
		if(enemies_in_range.has(collider)):
			active_target = raycast_enemy.get_collider();
			return true;
		return false;
	else:
		return false;

func shoot_single_round():
	var bullet: Area2D = projectiles_array[projectiles_left];
	bullet.transform.origin = projectile_spawn_node.global_position;
	
	bullet.set_global_rotation(global_rotation);
	var direction = global_transform.x;
	direction.x = randf_range(direction.x + Constants.PROJECTILE_ANGLE_ERROR, direction.x - Constants.PROJECTILE_ANGLE_ERROR);
	direction.y = randf_range(direction.y + Constants.PROJECTILE_ANGLE_ERROR, direction.y - Constants.PROJECTILE_ANGLE_ERROR);
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
	
func enable():
	set_physics_process(true);
	
func look_at_active_target(delta:float):
	var direction = (active_target.global_position - global_position).angle()
	global_rotation = lerp_angle(global_rotation, direction, TURN_SPEED * delta)
	if(current_shooting_interval >= shoot_interval_in_sec):
		if(enemy_in_sight() && !is_reloading):
			print("shoot")
			shoot_single_round();
			current_shooting_interval = 0.0
	else :
		current_shooting_interval += delta
