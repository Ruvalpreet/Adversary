extends Node

var controlable_character: Array[CharacterBody2D];
var selected_character: CharacterBody2D;


func select_character(character: Node):
	if selected_character:
		selected_character.is_selected = false
	selected_character = character
	selected_character.is_selected = true
