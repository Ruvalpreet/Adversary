extends Unit


@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;

@onready var dead_ship_sprite: Sprite2D = $dead_sprite;
@onready var pathfinder_timer: Timer = $PathFinder_timer;
@onready var weapon_node: Node2D = $weapon_1_color_3;

var mouse_position: Vector2;

func _ready() -> void:
	mouse_position =  Vector2(randi_range(0,1000), randi_range(0,1000));
	await create_unit(Constants.ENEMY,100,10,5000, Constants.ENEMY_ADVERSARY, dead_ship_sprite, unit_animation, pathfinder_timer);
	

func _physics_process(delta: float) -> void:
	if(velocity.is_zero_approx()):
		idle();
	movement(delta);


func _on_timer_timeout() -> void:
	mouse_position =  Vector2(randi_range(0,1000), randi_range(0,1000))
	destination_pathfinding(mouse_position, navigation_agent);

func _on_projectile_collider_area_entered(area: Area2D) -> void:
	print("shit shoot")
	damage_take(area);
