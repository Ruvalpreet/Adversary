extends Node2D

@onready var enemy_1: PackedScene = preload("res://scene/enemy_2_color_3.tscn");
@onready var enemy_2: PackedScene  = preload("res://scene/enemy_1_color_3.tscn");
@onready var enemy_3: PackedScene = preload("res://scene/enemy_4_color_3.tscn");
@onready var enemy_4: PackedScene = preload("res://scene/enemy_3_color_3.tscn");

@onready var ally_1: PackedScene = preload("res://scene/player_2_color_1.tscn");
@onready var ally_2: PackedScene = preload("res://scene/player_3_color_1.tscn");
@onready var ally_3: PackedScene = preload("res://scene/player_4_color_1.tscn");
@onready var map: Node2D = $Map;
var total_number_of_enemies_on_map: int;
var total_number_of_allies_on_map: int;

func unit_die(enemy_score: int,unit_type: String):
	if(unit_type == Constants.PLAYER):
		total_number_of_allies_on_map -= 1;
		if(total_number_of_allies_on_map <= 20):
			call_deferred("spawn_random_ally")
		return
	total_number_of_enemies_on_map -= 1;
	if(total_number_of_enemies_on_map <= 20):
		call_deferred("spawn_random_enemy")
		

func spawn_enemy_1():
	var enemy_1_instance = enemy_1.instantiate();
	enemy_1_instance.unit_died.connect(unit_die)
	enemy_1_instance.global_position = Vector2(randi_range(1000,2000), randi_range(-500,-200))
	map.add_child(enemy_1_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_2():
	var enemy_2_instance = enemy_2.instantiate();
	enemy_2_instance.unit_died.connect(unit_die)
	enemy_2_instance.global_position = Vector2(randi_range(1000,2000), randi_range(-500,-200))
	map.add_child(enemy_2_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_3():
	var enemy_3_instance = enemy_3.instantiate();
	enemy_3_instance.unit_died.connect(unit_die)
	enemy_3_instance.global_position = Vector2(randi_range(1000,2000), randi_range(-500,-200))
	map.add_child(enemy_3_instance);
	total_number_of_enemies_on_map += 1;

func spawn_ally_1():
	var ally_1_instance = ally_1.instantiate();
	ally_1_instance.unit_died.connect(unit_die)
	ally_1_instance.global_position = Vector2(randi_range(-1000,0), randi_range(900,1000))
	map.add_child(ally_1_instance);
	total_number_of_allies_on_map += 1;
	
func spawn_ally_2():
	var ally_2_instance = ally_2.instantiate();
	ally_2_instance.unit_died.connect(unit_die)
	ally_2_instance.global_position = Vector2(randi_range(-1000,0), randi_range(900,1000))
	map.add_child(ally_2_instance);
	total_number_of_allies_on_map += 1;

func spawn_ally_3():
	var ally_3_instance = ally_3.instantiate();
	ally_3_instance.unit_died.connect(unit_die)
	ally_3_instance.global_position = Vector2(randi_range(-1000,0), randi_range(900,1000))
	map.add_child(ally_3_instance);
	total_number_of_allies_on_map += 1;

func spawn_random_enemy():
	var rand: float = randf()
	if(rand < 0.33):
		spawn_enemy_1();
	elif (rand < 0.66):
		spawn_enemy_2();
	else:
		spawn_enemy_3();
		

func spawn_random_ally():
	var rand: float = randf()
	if(rand < 0.33):
		spawn_ally_1();
	elif (rand < 0.66):
		spawn_ally_2();
	else:
		spawn_ally_3();
		


func _on_spawner_timeout() -> void:
	if(total_number_of_enemies_on_map <=25):
		spawn_random_enemy();
		spawn_random_ally();
