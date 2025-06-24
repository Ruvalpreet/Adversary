extends Node2D
@onready var enemy_1: PackedScene = preload("res://scene/enemy_2_color_3.tscn");
@onready var enemy_2: PackedScene  = preload("res://scene/enemy_1_color_3.tscn");
@onready var enemy_3: PackedScene = preload("res://scene/enemy_4_color_3.tscn");
@onready var enemy_4: PackedScene = preload("res://scene/enemy_3_color_3.tscn");

@onready var screen_ui: Control = $CanvasLayer/GUI;
var total_score_node: Label;
var total_enemy_node: Label;

var selected_character: CharacterBody2D;

var total_score:int;
var total_number_of_enemies_on_map: int;

func _ready() -> void:
	total_score_node = screen_ui.get_node("total_score");
	total_enemy_node = screen_ui.get_node("total_enemies");
	if(total_number_of_enemies_on_map <= 50):
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
		spawn_enemy_1();
	elif (rand < 0.5):
		spawn_enemy_2();
		spawn_enemy_2();
	elif (rand < 0.75):
		spawn_enemy_3();
		spawn_enemy_3();
	else :
		spawn_enemy_1();
		spawn_enemy_1();
		

func select_character(character: CharacterBody2D):
	if selected_character:
		selected_character.is_selected = false
	selected_character = character
	selected_character.is_selected = true
	
func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_cancel")):
		get_tree().paused = true;
