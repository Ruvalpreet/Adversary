extends Unit

@onready var enemy_detactor: Area2D = $Enemy_detact;
@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;
@onready var weapon_animation: Node2D = $Weapon_1_color_1;
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;
@onready var raycasting: RayCast2D = $RayCast2D;
var projectile: PackedScene = preload("res://scene/player_projectile_single.tscn")
var mouse_position: Vector2;

var is_selected: bool;

func _ready() -> void:
	mouse_position = get_global_mouse_position();
	create_unit(Constants.PLAYER,100,10,5000, 10000, 20, projectile);
	raycasting.set_enabled(true)
	

func _physics_process(delta: float) -> void:
	if(velocity.is_zero_approx()):
		idle(unit_animation)
	if(!enemies_in_range.is_empty()):
		enemy_in_area(weapon_animation, projectile, raycasting, delta)
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position = get_global_mouse_position();
	destination_pathfinding(mouse_position, navigation_agent);

func _on_enemy_detact_body_entered_ship_enterd(body: Node2D) -> void:
	if(body.is_in_group(Constants.ENEMY)):
		enemies_in_range.append(body)
	pass

func _on_enemy_detact_body_exited_ship_exited(body: Node2D) -> void:
	if(body.is_in_group(Constants.ENEMY)):
		enemies_in_range.erase(body)
	pass # Replace with function body.
