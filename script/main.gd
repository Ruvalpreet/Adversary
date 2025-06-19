extends Node2D
@onready var enemy_1: PackedScene = preload("res://scene/enemy_2_color_3.tscn");
@onready var enemy_2: PackedScene  = preload("res://scene/enemy_1_color_3.tscn");
@onready var enemy_3: PackedScene = preload("res://scene/enemy_4_color_3.tscn");
@onready var enemy_4: PackedScene = preload("res://scene/enemy_3_color_3.tscn");


var total_number_of_enemies_on_map: int;

func _ready() -> void:
	spawn_enemy_1();
	spawn_enemy_1();

func enemy_die():
	print("shti works")
	total_number_of_enemies_on_map -= 1;
	call_deferred("spawn_random_enemy")

func spawn_enemy_1():
	var enemy_1_instance = enemy_1.instantiate();
	enemy_1_instance.unit_died.connect(enemy_die)
	enemy_1_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_1_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_2():
	var enemy_2_instance = enemy_2.instantiate();
	enemy_2_instance.unit_died.connect(enemy_die)
	enemy_2_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_2_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_3():
	var enemy_3_instance = enemy_3.instantiate();
	enemy_3_instance.unit_died.connect(enemy_die)
	enemy_3_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_3_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_4():
	var enemy_4_instance = enemy_4.instantiate();
	enemy_4_instance.unit_died.connect(enemy_die)
	enemy_4_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_4_instance);
	total_number_of_enemies_on_map += 1;

func spawn_random_enemy():
	var rand: float = randf()
	if(rand < 0.25):
		spawn_enemy_1();
		spawn_enemy_1();
	elif (rand < 0.5):
		spawn_enemy_2();
		spawn_enemy_2();
	elif (rand < 0.75):
		spawn_enemy_3();
		spawn_enemy_3();
	else :
		spawn_enemy_4();
		spawn_enemy_4();
