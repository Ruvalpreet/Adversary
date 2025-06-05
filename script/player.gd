extends Unit


@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;

@onready var dead_ship_sprite: Sprite2D = $dead_sprite;
@onready var pathfinder_timer: Timer = $PathFinding_timer;
@onready var weapon_node: Node2D = $Weapon_1_color_1;

var projectile: PackedScene = preload("res://scene/player_projectile_single.tscn")
var mouse_position: Vector2;

var is_selected: bool;

func _ready() -> void:
	mouse_position = get_global_mouse_position();
	await create_unit(Constants.PLAYER,100,10,5000, Constants.PLAYER_ADVERSARY, dead_ship_sprite, unit_animation, pathfinder_timer);
	

func _physics_process(delta: float) -> void:
	if(velocity.is_zero_approx()):
		idle();
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position = get_global_mouse_position();
	destination_pathfinding(mouse_position, navigation_agent);

func _on_pro_jectile_collider_area_entered(area: Area2D) -> void:
	damage_take(area);
