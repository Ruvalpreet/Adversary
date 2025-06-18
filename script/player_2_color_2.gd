extends Unit


@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;

@onready var pathfinder_timer: Timer = $PathFinding_timer;


var mouse_position: Vector2;

func _ready() -> void:
	mouse_position = get_global_mouse_position();
	weapon_node = $Weapon_2_color_1;
	await create_unit(Constants.PLAYER,1000,5000, Constants.PLAYER_ADVERSARY, unit_animation, pathfinder_timer);
	navigation_agent =$NavigationAgent2D

func _physics_process(delta: float) -> void:
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position =  Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	destination_pathfinding(mouse_position);

func _on_projectile_collider_area_entered(area: Area2D) -> void:
	damage_take(area);
