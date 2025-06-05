class_name Unit extends CharacterBody2D


var maxHealth: int;
var current_health: int;
var damage: int;
var movement_speed: int;
var new_velocity: Vector2;

var moving: bool = true;

var adversary: Array[String];
var dead_sprit: Sprite2D;
var unit_live_animation: AnimatedSprite2D;
var path_finding_timer: Timer;

#Unit creation function NOTE: NEED TO RUN IN _READY.
func create_unit(unit_type:String, maxHealth: int, damage: int, movement_speed: int, adversary: Array[String], dead_sprit: Sprite2D, unit_live_animation: AnimatedSprite2D, path_finding_timer: Timer) -> void:
	if(unit_type == Constants.PLAYER):
		Global.controllable_character.append(self);
	add_to_group(unit_type);
	self.maxHealth = maxHealth;
	self.current_health = maxHealth;
	self.damage = damage;
	self.movement_speed = movement_speed;
	self.adversary = adversary;
	dead_sprit.visible = false;
	self.dead_sprit = dead_sprit;
	self.unit_live_animation = unit_live_animation;
	self.path_finding_timer = path_finding_timer;
	
	print("intital data",get_groups());

func movement(delta: float) -> void:
	velocity = new_velocity * delta;
	move_and_slide();


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
