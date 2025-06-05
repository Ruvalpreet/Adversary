extends Unit


@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;

@onready var pathfinder_timer: Timer = $PathFinding_timer;
@onready var weapon_node: Node2D = $Weapon_1_color_1;


var mouse_position: Vector2;

func _ready() -> void:
	mouse_position = get_global_mouse_position();
	await create_unit(Constants.PLAYER,10000,5000, Constants.PLAYER_ADVERSARY, unit_animation, pathfinder_timer);
	navigation_agent =$NavigationAgent2D

func _physics_process(delta: float) -> void:
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position = get_global_mouse_position();
	destination_pathfinding(mouse_position);

func _on_pro_jectile_collider_area_entered(area: Area2D) -> void:
	damage_take(area);
