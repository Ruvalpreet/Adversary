extends Node2D

@onready var dead_sprite_1: Sprite2D = $dead_1;
@onready var dead_sprite_2: Sprite2D = $dead_2;
@onready var dead_sprite_3: Sprite2D = $dead_3;
@onready var dead_sprite_4: Sprite2D = $dead_4;

func _ready() -> void:
	var rand: float = randf();
	if(rand < 0.25):
		dead_sprite_1.visible = true;
	elif (rand < 0.5):
		dead_sprite_2.visible = true;
	if(rand < 0.75):
		dead_sprite_3.visible = true;
	else:
		dead_sprite_4.visible = true;

func _on_timer_timeout() -> void:
	queue_free()
