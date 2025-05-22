extends Unit

var mouse_position: Vector2;
var enemy_detactor: Area2D;
var is_selected: bool;

func _ready() -> void:
	movement_speed = 50;
	enemy_detactor = $Enemy_detact;
	mouse_position = get_global_mouse_position();
	Global.controlable_character.append(self);
	return;
	
func _physics_process(delta: float) -> void:
	movement();
	if(velocity.is_zero_approx()):
		print("what is the velocity", velocity, name)
		idle($AnimatedSprite2D, "idle")


func _on_timer_timeout() -> void:
	mouse_position = get_global_mouse_position();
	destination_pathfinding(mouse_position, $NavigationAgent2D);

func take_control() -> void:
	Global.CONTROLLED_UNIT = name;

func _on_enemy_detact_body_entered_ship_enterd(body: Node2D) -> void:
	pass

func _on_enemy_detact_body_exited_ship_exited(body: Node2D) -> void:
	pass # Replace with function body.
