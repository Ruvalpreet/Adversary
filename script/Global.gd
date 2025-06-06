extends Node

var controllable_character: Array[CharacterBody2D];
var selected_character: CharacterBody2D;
var dead_ship_sprite_1: PackedScene = preload("res://scene/dead_ship_sprite_1.tscn")

func select_character(character: CharacterBody2D):
	if selected_character:
		selected_character.is_selected = false
	selected_character = character
	selected_character.is_selected = true

func GET_DEAD_SHIP_SPRITE(location: Vector2, rotation_angle: float):
	var new_dead_ship: Sprite2D = dead_ship_sprite_1.instantiate();
	new_dead_ship.visible = true;
	print("what is the direction ", rad_to_deg(rotation_angle))
	new_dead_ship.global_position = location;
	new_dead_ship.set_rotation(rotation_angle - deg_to_rad(90));
	var death_animation: AnimatedSprite2D = new_dead_ship.get_node("DeathAnimatedSprite2D");
	get_tree().current_scene.add_child(new_dead_ship);
	death_animation.play(Constants.ANIMATION_DEATH)
