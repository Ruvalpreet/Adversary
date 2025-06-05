extends Weapon

var projectile_player: PackedScene = preload("res://scene/player_projectile_single.tscn")

func _ready() -> void:
	total_number_of_projectiles = 20;
	reload_timer_node = $Reload;
	projectile = projectile_player;
	raycast_enemy = $AnimatedSprite2D/RayCast2D;
	projectile_spawn_node = $AnimatedSprite2D/BulletSpawner;
	projectile_range = 500;
	damage = 10;
	sprite_node = $AnimatedSprite2D
	constructor();
	

func _physics_process(delta: float) -> void:
	look_at_active_target(delta);

func _on_reload_timeout() -> void:
	is_reloading = true;
	reload_ammo()

func _on_area_2d_body_entered(body: Node2D) -> void:
	enemies_in_range.append(body);
	enable();
	if(!active_target):
		active_target = body;

func _on_area_2d_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body);
	if(enemies_in_range.is_empty()):
		disable();
