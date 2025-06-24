extends Weapon

var projectile_player: PackedScene = preload("res://scene/player_projectile_single.tscn")

func _ready() -> void:
	total_number_of_projectiles = 200;
	reload_timer_node = $Reload;
	projectile = projectile_player;
	raycast_enemy = $AnimatedSprite2D/RayCast2D;
	projectile_spawn_node = $AnimatedSprite2D/BulletSpawner;
	projectile_range = 650;
	shoot_interval_in_sec = 0.1;
	damage = 150;
	reloading_speed = 0.5;
	shoot_sprite_node = $AnimatedSprite2D;
	ray_and_shoot_timer = $RayAndShoot;
	ray_to_find_best_target = $FindBestTarget;
	check_active_target = $CheckActiveTarget;
	enemy_detector_arear_collider =$Area2D/CollisionShape2D;
	constructor();
	

func _physics_process(delta: float) -> void:
	look_at_mouse_target(delta);

func _on_reload_timeout() -> void:
	reload_ammo()

func _on_ray_and_shoot_timeout() -> void:
	enemy_in_sight();
	if(Input.is_action_pressed("shoot")):
		shoot_single_round();
		shoot_single_round();


func _on_check_active_target_timeout() -> void:
	get_active_target()

func look_at_mouse_target(delta:float):
	var direction = (get_global_mouse_position() - global_position).angle();
	global_rotation = lerp_angle(global_rotation, direction, TURN_SPEED * delta);
	
