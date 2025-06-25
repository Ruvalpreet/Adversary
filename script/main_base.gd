extends Unit

var weapon_node_2: Node2D;
@onready var sprite:Sprite2D = $Sprite2D;
func _ready() -> void:
	weapon_node = $main_ship_weapon_1_color_1;
	weapon_node_2 = $main_ship_weapon_1_color_2;
	unit_type = Constants.PLAYER;
	maxHealth = 1000;
	current_health = maxHealth;

func _on_projectile_collider_area_entered(area: Area2D) -> void:
	if(is_zero_approx(current_health) or current_health <= 0):
		dead()
	if(area.damage):
		area.disable_projectile();
		current_health -= area.damage;
		heath_ration = float(current_health) / maxHealth;
		sprite.set_self_modulate(Color(heath_ration,heath_ration,heath_ration))
		weapon_node.get_data_from_parent(heath_ration);
		weapon_node_2.get_data_from_parent(heath_ration);
