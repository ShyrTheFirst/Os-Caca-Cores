extends StaticBody2D

@export_color_no_alpha var color : Color
var body_handler

func _ready():
	self.modulate = color

func _process(delta):
	
	if body_handler != null:
		if body_handler.color == color:
			if !body_handler.dragging:
				GameManager.easy_mode_objects -= 1
				body_handler.queue_free()
				body_handler = null


func _on_object_detector_body_entered(body):
	body_handler = body


func _on_object_detector_body_exited(body):
	body_handler = null
