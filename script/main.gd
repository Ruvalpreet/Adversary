extends Node2D
@onready var enemy_1: PackedScene = preload("res://scene/enemy_2_color_3.tscn");
@onready var enemy_2: PackedScene  = preload("res://scene/enemy_1_color_3.tscn");
@onready var enemy_3: PackedScene = preload("res://scene/enemy_4_color_3.tscn");

@onready var ally_1: PackedScene = preload("res://scene/player_2_color_1.tscn");
@onready var ally_2: PackedScene = preload("res://scene/player_3_color_1.tscn");
@onready var ally_3: PackedScene = preload("res://scene/player_4_color_1.tscn");

var ally_1_gold: int = 50;
var ally_2_gold: int = 75;
var ally_3_gold: int = 100;

@onready var screen_ui: Control = $CanvasLayer/GUI;
var total_score_node: Label;
var total_enemy_node: Label;

var total_gold: int = 0;
var max_gold: int = 1000;
var total_gold_node: Label;
var gold_added_each_sec: int = 10;

var selected_character: CharacterBody2D;

var total_score:int;
var total_number_of_enemies_on_map: int;

func _ready() -> void:
	total_score_node = screen_ui.get_node("total_score");
	total_enemy_node = screen_ui.get_node("total_enemies");
	total_gold_node = screen_ui.get_node("gold_panel/total_gold");
	var ally_1_button = screen_ui.get_node("Panel/MoneyPanelEmptyHud/Button");
	ally_1_button.pressed.connect(spawn_allie_1);
	var ally_2_button = screen_ui.get_node("Panel/MoneyPanelEmptyHud2/Button2");
	ally_2_button.pressed.connect(spawn_allie_2);
	var ally_3_button = screen_ui.get_node("Panel/MoneyPanelEmptyHud3/Button3");
	ally_3_button.pressed.connect(spawn_allie_3);
	total_gold_node.text = str(total_gold);
	spawn_random_enemy();
	spawn_random_enemy();

func unit_die(enemy_score: int,unit_type):
	if(unit_type == Constants.PLAYER):
		return
	total_score += enemy_score
	total_number_of_enemies_on_map -= 1;
	total_score_node.set_text("Total score: " + str(total_score));
	total_enemy_node.set_text("Total Enemies: " + str(total_number_of_enemies_on_map))
	if(total_number_of_enemies_on_map <= 50):
		call_deferred("spawn_random_enemy")


func spawn_allie_1():
	if(total_gold < ally_1_gold):
		return
	total_gold -= ally_1_gold;
	var allie_1_instatace = ally_1.instantiate();
	allie_1_instatace.unit_died.connect(unit_die);
	get_tree().current_scene.add_child(allie_1_instatace);

func spawn_allie_2():
	if(total_gold < ally_2_gold):
		return
	total_gold -= ally_2_gold;
	var allie_2_instatace = ally_2.instantiate();
	allie_2_instatace.unit_died.connect(unit_die);
	get_tree().current_scene.add_child(allie_2_instatace);

func spawn_allie_3():
	if(total_gold < ally_3_gold):
		return
	total_gold -= ally_3_gold;
	var allie_3_instatace = ally_3.instantiate();
	allie_3_instatace.unit_died.connect(unit_die);
	get_tree().current_scene.add_child(allie_3_instatace);

func spawn_enemy_1():
	var enemy_1_instance = enemy_1.instantiate();
	enemy_1_instance.unit_died.connect(unit_die)
	enemy_1_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_1_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_2():
	var enemy_2_instance = enemy_2.instantiate();
	enemy_2_instance.unit_died.connect(unit_die)
	enemy_2_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_2_instance);
	total_number_of_enemies_on_map += 1;

func spawn_enemy_3():
	var enemy_3_instance = enemy_3.instantiate();
	enemy_3_instance.unit_died.connect(unit_die)
	enemy_3_instance.global_position = Vector2(randi_range(-1850,3050), randi_range(-1450,1000))
	get_tree().current_scene.add_child(enemy_3_instance);
	total_number_of_enemies_on_map += 1;

func spawn_random_enemy():
	var rand: float = randf()
	if(rand < 0.25):
		spawn_enemy_1();
	elif (rand < 0.5):
		spawn_enemy_2();
	elif (rand < 0.75):
		spawn_enemy_3();
	else :
		spawn_enemy_1();
		


func _on_gold_timer_timeout() -> void:
	if(total_gold + gold_added_each_sec > max_gold):
		total_gold = max_gold;
		total_gold_node.text = str(total_gold);
		return
	total_gold += gold_added_each_sec;
	total_gold_node.text = str(total_gold);
