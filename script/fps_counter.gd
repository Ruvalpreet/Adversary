#extends Node2D
#
#const TIMER_LIMIT = 1.0
#var timer = 0.0
#@onready var label: Label = $Label
#
#func _process(delta: float) -> void:
	#timer += delta
	#if timer > TIMER_LIMIT: # Prints every 2 seconds
		#timer = 0.0
		#var text = "fps: " + str(Engine.get_frames_per_second())
		#label.set_text(text)
		#print("fps: " + str(Engine.get_frames_per_second()))
