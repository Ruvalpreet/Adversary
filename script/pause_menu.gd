extends Control


func _on_button_pressed() -> void:
	get_tree().paused = false;
	Global.main_menu();
	visible = false
	


func _on_button_pressed_unpause() -> void:
	get_tree().paused = false;
	visible = false
