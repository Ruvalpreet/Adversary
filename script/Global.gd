extends Node

var controllable_character: Array[CharacterBody2D];
var dead_ship_sprite_1: PackedScene = preload("res://scene/dead_ship_sprite_1.tscn")
var main_manu: PackedScene = preload("res://scene/main_menu.tscn");
var game_main: PackedScene = preload("res://scene/main.tscn");

var bullet_storage_node: Node2D;
var main_game_instance: Node2D;
var main_menu_instance: Node2D;


@onready var main_runner: PackedScene = preload("res://scene/test.tscn")

func _ready() -> void:
	main_menu_instance = main_manu.instantiate();
	bullet_storage_node = get_tree().get_root().find_child("bullet_storage", true, false);
	var play_button: Button = main_menu_instance.get_node("play/Button");
	play_button.pressed.connect(play)
	get_tree().current_scene.add_child(main_menu_instance);
	get_tree().current_scene.move_child(main_menu_instance, 0);


func play():
	get_tree().current_scene.remove_child(main_menu_instance);
	get_tree().current_scene.remove_child(main_game_instance);
	if bullet_storage_node:
		for child in bullet_storage_node.get_children():
			child.queue_free()
	main_game_instance = game_main.instantiate();
	get_tree().current_scene.add_child(main_game_instance);
	get_tree().current_scene.move_child(main_game_instance, 0)


func GET_DEAD_SHIP_SPRITE(location: Vector2, rotation_angle: float) -> Node2D:
	var new_dead_ship: Node2D = dead_ship_sprite_1.instantiate();
	new_dead_ship.global_position = location;
	new_dead_ship.set_rotation(rotation_angle - deg_to_rad(90));
	var death_animation: AnimatedSprite2D = new_dead_ship.get_node("DeathAnimatedSprite2D");
	death_animation.play(Constants.ANIMATION_DEATH)
	return new_dead_ship;
	
func main_menu():
	main_menu_instance = main_manu.instantiate();
	get_tree().current_scene.remove_child(main_game_instance);
	if bullet_storage_node:
		for child in bullet_storage_node.get_children():
			child.queue_free()
	var play_button: Button = main_menu_instance.get_node("play/Button");
	play_button.pressed.connect(play)
	get_tree().current_scene.add_child(main_menu_instance);
	get_tree().current_scene.move_child(main_menu_instance, 0);
