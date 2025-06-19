extends Node

var controllable_character: Array[CharacterBody2D];
var dead_ship_sprite_1: PackedScene = preload("res://scene/dead_ship_sprite_1.tscn")
var main_manu: PackedScene = preload("res://scene/main_menu.tscn");
var game_main: PackedScene = preload("res://scene/main.tscn");

var main_scene: Node2D;

func _ready() -> void:
	main_scene = main_manu.instantiate();
	var play_button: Button = main_scene.get_node("play/Button");
	print("is node their", play_button)
	play_button.pressed.connect(play)
	get_tree().current_scene.add_child(main_scene);


func play():
	get_tree().current_scene.remove_child(main_scene);
	var main_game = game_main.instantiate();
	get_tree().current_scene.add_child(main_game);


func GET_DEAD_SHIP_SPRITE(location: Vector2, rotation_angle: float):
	var new_dead_ship: Sprite2D = dead_ship_sprite_1.instantiate();
	new_dead_ship.visible = true;
	new_dead_ship.global_position = location;
	new_dead_ship.set_rotation(rotation_angle - deg_to_rad(90));
	var death_animation: AnimatedSprite2D = new_dead_ship.get_node("DeathAnimatedSprite2D");
	get_tree().current_scene.add_child(new_dead_ship);
	death_animation.play(Constants.ANIMATION_DEATH)
