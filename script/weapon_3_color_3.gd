extends Weapon

var projectile_enemy: PackedScene = preload("res://scene/enemy_projectile_single.tscn")

func _ready() -> void:
	total_number_of_projectiles = 10;
	reload_timer_node = $Reload;
	projectile = projectile_enemy;
	raycast_enemy = $AnimatedSprite2D/RayCast2D;
	projectile_spawn_node = $AnimatedSprite2D/BulletSpawner;
	projectile_range = 400;
	shoot_interval_in_sec = 0.5;
	damage = 0;
	reloading_speed = 2.0;
	shoot_sprite_node = $AnimatedSprite2D;
	ray_and_shoot_timer = $RayAndShoot;
	ray_to_find_best_target = $FindBestTarget;
	check_active_target = $CheckActiveTarget;
	enemy_detector_arear_collider =$Area2D/CollisionShape2D;
	constructor();
	

func _physics_process(delta: float) -> void:
	look_at_active_target(delta);

func _on_reload_timeout() -> void:
	reload_ammo()

func _on_area_2d_body_entered(body: Node2D) -> void:
	enemies_in_range.append(body);
	enable();

func _on_area_2d_body_exited(body: Node2D) -> void:
	enemies_in_range.erase(body);
	if(enemies_in_range.is_empty()):
		disable();


func _on_ray_and_shoot_timeout() -> void:
	enemy_in_sight();


func _on_check_active_target_timeout() -> void:
	get_active_target();
