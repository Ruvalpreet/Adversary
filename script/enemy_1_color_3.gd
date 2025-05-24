extends Unit

@onready var enemy_detactor: Area2D = $Area2D;
@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;
@onready var weapon_animation: Node2D = $weapon_1_color_3;
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;
var projectile: PackedScene = preload("res://scene/player_projectile_single.tscn")
var mouse_position: Vector2;

var is_selected: bool;

func _ready() -> void:
	mouse_position = Vector2(randi_range(0,500), randi_range(0,500));
	create_unit(Constants.ENEMY,100,10,5000, 10000, 100, projectile);
	
func _physics_process(delta: float) -> void:
	movement(delta);
	if(velocity.is_zero_approx()):
		idle(unit_animation)


func _on_timer_timeout() -> void:
	mouse_position = Vector2(randi_range(0,500), randi_range(0,500));
	destination_pathfinding(mouse_position, navigation_agent);

func _on_enemy_detact_body_entered_ship_enterd(body: Node2D) -> void:
	if(body.is_in_group(Constants.PLAYER)):
		pass
		#enemy_in_area(weapon_animation,preload("res://scene/player_projectile_single.tscn"),$RayCast2D )
	pass

func _on_enemy_detact_body_exited_ship_exited(body: Node2D) -> void:
	pass # Replace with function body.
