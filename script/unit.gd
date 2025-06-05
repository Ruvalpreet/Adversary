class_name Unit extends CharacterBody2D

const TURN_SPEED: float = 2.5;

var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var new_velocity: Vector2;

var moving: bool = true;

var adversary: Array[String];
var unit_live_animation: AnimatedSprite2D;
var path_finding_timer: Timer;

var navigation_agent: NavigationAgent2D;

func create_unit(unit_type:String, maxHealth: int, damage: int, movement_speed: int, adversary: Array[String], unit_live_animation: AnimatedSprite2D, path_finding_timer: Timer) -> void:
	if(unit_type == Constants.PLAYER):
		Global.controllable_character.append(self);
	add_to_group(unit_type);
	self.maxHealth = maxHealth;
	self.current_health = maxHealth;
	self.damage = damage;
	self.movement_speed = movement_speed;
	self.adversary = adversary;
	self.unit_live_animation = unit_live_animation;
	self.path_finding_timer = path_finding_timer;
	
	print("intital data",get_groups());


func movement(delta: float) -> void:
	if not moving:
		return
	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var next_position = navigation_agent.get_next_path_position()
	var desired_angle = (next_position - global_position).angle()
	rotation = lerp_angle(rotation, desired_angle, TURN_SPEED * delta)
	var forward_dir = Vector2.RIGHT.rotated(rotation)
	velocity = forward_dir * movement_speed * delta

	move_and_slide()


func destination_pathfinding(destination: Vector2) -> void:
	if moving:
		navigation_agent.target_position = destination


func damage_take(damage_collision_node: Area2D):
	if(is_zero_approx(current_health)):
		dead()
	if(damage_collision_node.damage):
		damage_collision_node.disable_projectile();
		current_health -= damage_collision_node.damage;
		
func dead():
	Global.GET_DEAD_SHIP_SPRITE(self.global_position, transform.x.angle());
	queue_free();
