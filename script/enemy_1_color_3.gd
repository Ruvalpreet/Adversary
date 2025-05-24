extends Unit

@onready var enemy_detactor: Area2D = $Area2D;
@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;
@onready var weapon_animation: Node2D = $weapon_1_color_3;
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;
@onready var raycasting: RayCast2D = $Node2D/RayCast2D;
@onready var raycast_controller: Node2D = $Node2D;

var projectile: PackedScene = preload("res://scene/player_projectile_single.tscn")
var mouse_position: Vector2;

var is_selected: bool;

func _ready() -> void:
	mouse_position = Vector2(randi_range(0,500), randi_range(0,500));
	create_unit(Constants.ENEMY,100,10,5000, 10, projectile, Constants.ENEMY_ADVERSARY);
	
func _physics_process(delta: float) -> void:
	if(velocity.is_zero_approx()):
		idle(unit_animation)
	if(!enemies_in_range.is_empty()):
		enemy_in_area(weapon_animation, raycasting,raycast_controller, delta)
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position = Vector2(randi_range(0,1000), randi_range(0,1000));
	destination_pathfinding(mouse_position, navigation_agent);

func _on_enemy_detact_body_entered_ship_enterd(body: Node2D) -> void:
	if(body.is_in_group(Constants.PLAYER)):
		enemies_in_range.append(body)
	pass


func _on_enemy_detact_body_exited_ship_exited(body: Node2D) -> void:
	if(body.is_in_group(Constants.PLAYER)):
		enemies_in_range.erase(body)
	pass # Replace with function b
