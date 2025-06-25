class_name Unit extends CharacterBody2D
signal unit_died(enemy_score:int, unit_type:String)

const TURN_SPEED: float = 2.5;

var maxHealth: int;
var current_health: int;
var heath_ration: float;

var movement_speed: int;
var new_velocity: Vector2;

var adversary: Array[String];
var unit_live_animation: AnimatedSprite2D;
var path_finding_timer: Timer;

var weapon_node: Node2D;
var navigation_agent: NavigationAgent2D;

var unit_score: int = 0;
var unit_type: String;

func create_unit(unit_type:String, maxHealth: int, movement_speed: int, adversary: Array[String], unit_live_animation: AnimatedSprite2D, path_finding_timer: Timer) -> void:
	if(unit_type == Constants.PLAYER):
		Global.controllable_character.append(self);
	add_to_group(unit_type);
	self.unit_type = unit_type;
	self.maxHealth = maxHealth;
	self.current_health = maxHealth;
	self.movement_speed = movement_speed;
	self.adversary = adversary;
	self.unit_live_animation = unit_live_animation;
	self.path_finding_timer = path_finding_timer;
	unit_live_animation.play(Constants.ANIMATION_IDLE)
	print("intital data",get_groups());


func movement(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
		set_physics_process(false)
		return
	var next_position = navigation_agent.get_next_path_position()
	var desired_angle = (next_position - global_position).angle()
	rotation = lerp_angle(rotation, desired_angle, TURN_SPEED * delta)
	var forward_dir = transform.x;
	velocity = forward_dir * movement_speed * delta
	move_and_slide()


func destination_pathfinding(destination: Vector2) -> void:
	if(!is_physics_processing()):
		set_physics_process(true);
	navigation_agent.target_position = destination


func damage_take(damage_collision_node: Area2D):
	if(is_zero_approx(current_health) or current_health <= 0):
		dead()
	if(damage_collision_node.damage):
		damage_collision_node.disable_projectile();
		current_health -= damage_collision_node.damage;
		heath_ration = float(current_health) / maxHealth;
		unit_live_animation.set_self_modulate(Color(heath_ration,heath_ration,heath_ration))
		weapon_node.get_data_from_parent(heath_ration);
		
func dead():
	if (unit_type == Constants.ENEMY):
		unit_died.emit(unit_score, Constants.ENEMY);
	else:
		unit_died.emit(unit_score, Constants.PLAYER);
	var death_sprite: Node2D = Global.GET_DEAD_SHIP_SPRITE(self.global_position, transform.x.angle());
	self.add_sibling(death_sprite)
	queue_free();
