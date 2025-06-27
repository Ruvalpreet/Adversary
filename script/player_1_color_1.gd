extends Unit
signal game_ends()

@onready var unit_animation: AnimatedSprite2D = $AnimatedSprite2D;

@onready var pathfinder_timer: Timer = $PathFinding_timer;

@onready var ui_icon: Sprite2D = $Sprite2D;

var mouse_position: Vector2;

func _ready() -> void:
	mouse_position = get_global_mouse_position();
	weapon_node = $Weapon_1_color_1;
	await create_unit(Constants.PLAYER,100,5000, Constants.PLAYER_ADVERSARY, unit_animation, pathfinder_timer);
	navigation_agent =$NavigationAgent2D

func _physics_process(delta: float) -> void:
	player_controls(delta);


#func _on_timer_timeout() -> void:
	#mouse_position = get_global_mouse_position();
	#destination_pathfinding(mouse_position);

func _on_projectile_collider_area_entered(area: Area2D) -> void:
	if(is_zero_approx(current_health) or current_health <= 0):
		game_ends.emit();
		dead()
	if(area.damage):
		area.disable_projectile();
		current_health -= area.damage;
		heath_ration = float(current_health) / maxHealth;
		unit_live_animation.set_self_modulate(Color(heath_ration,heath_ration,heath_ration))
		weapon_node.get_data_from_parent(heath_ration);

func player_controls(delta: float):
	var direction: Vector2;
	if(Input.is_action_pressed("forward")):
		direction += transform.x.normalized() * delta * movement_speed;
	if(Input.is_action_pressed("left")):
		rotation -= TURN_SPEED * delta 
	if(Input.is_action_pressed("right")):
		rotation += TURN_SPEED * delta 
	velocity = direction;
	move_and_slide()
