extends Control

func _ready() -> void:
	visible = false;

func _on_button_2_pressed() -> void:
	get_tree().paused = false;
	Global.main_menu();
	visible = false


func _on_button_pressed() -> void:
	get_tree().paused = false;
	Global.play();
	visible = false
