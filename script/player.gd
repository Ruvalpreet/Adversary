extends Unit

@onready var enemy_detactor: Area2D = $Enemy_detact;
@onready var enemy_detactor_collider: CollisionShape2D = $Enemy_detact/CollisionShape2D;
@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;
@onready var weapon_animation: Node2D = $Weapon_1_color_1;
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;
@onready var raycasting: RayCast2D = $RayCastController/RayCast2D;
@onready var raycast_controller: Node2D = $RayCastController;
@onready var reload_timer: Timer = $Reload_Timer;
@onready var dead_ship_sprite: Sprite2D = $dead_sprite;
@onready var pathfinder_timer: Timer = $PathFinding_timer;
@onready var bullet_spawner: Node2D = $Projectile_spawn;

var projectile: PackedScene = preload("res://scene/player_projectile_single.tscn")
var mouse_position: Vector2;

var is_selected: bool;

func _ready() -> void:
	mouse_position = get_global_mouse_position();
	await create_unit(Constants.PLAYER,200,10,5000, 10, projectile, Constants.PLAYER_ADVERSARY, 500, enemy_detactor_collider, raycasting, reload_timer, 1,dead_ship_sprite,unit_animation, pathfinder_timer, bullet_spawner);
	raycasting.set_enabled(true)
	

func _physics_process(delta: float) -> void:
	if(velocity.is_zero_approx()):
		idle();
	if(!enemies_in_range.is_empty()):
		enemy_in_area(weapon_animation, raycasting,raycast_controller, delta)
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position = get_global_mouse_position();
	destination_pathfinding(mouse_position, navigation_agent);

func _on_enemy_detact_body_entered_ship_enterd(body: Node2D) -> void:
	for i in adversary:
		if(body.is_in_group(i)):
			enemies_in_range.append(body);

func _on_enemy_detact_body_exited_ship_exited(body: Node2D) -> void:
	for i in adversary:
		if(body.is_in_group(i)):
			enemies_in_range.erase(body);
		if(enemies_in_range.is_empty()):
			moving = true;



func _on_reload_timer_timeout() -> void:
	reload_ammo()


func _on_pro_jectile_collider_area_entered(area: Area2D) -> void:
	damage_take(area);
