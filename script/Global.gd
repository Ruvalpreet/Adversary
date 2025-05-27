extends Node

var controllable_character: Array[CharacterBody2D];
var selected_character: CharacterBody2D;
var dead_ship_sprite_1: PackedScene = preload("res://scene/dead_ship_sprite_1.tscn")

func select_character(character: CharacterBody2D):
	if selected_character:
		selected_character.is_selected = false
	selected_character = character
	selected_character.is_selected = true

func GET_DEAD_SHIP_SPRITE(location: Vector2):
	var new_dead_ship: Sprite2D = dead_ship_sprite_1.instantiate();
	new_dead_ship.visible = true;
	new_dead_ship.global_position = location;
	var look_at_direction: Vector2 = Vector2.ZERO
	new_dead_ship.look_at(look_at_direction);
	get_tree().current_scene.add_child(new_dead_ship);
