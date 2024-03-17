extends Node2D

@export_color_no_alpha var color : Color

var draggable = false
var is_inside_dropable = false
var is_inside_correct_color = false
var body_ref
var body_color
var offset : Vector2
var initialPos : Vector2
var already_placed = false

func _ready():
	randomize()
	var color_options = [Color.RED, Color.BLUE, Color.GREEN]
	color = color_options.pick_random()
	self.modulate = color

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("Click"):
			initialPos = global_position
			GameManager.isDragging = true
			offset = get_global_mouse_position() - global_position
		if Input.is_action_pressed("Click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("Click"):
			GameManager.isDragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				if body_color == self.modulate:
					is_inside_correct_color = true
					already_placed = true
					tween.tween_property(self, "position", body_ref.position,0.1).set_ease(Tween.EASE_OUT)
				else:
					tween.tween_property(self, "global_position", initialPos,0.1).set_ease(Tween.EASE_OUT)
			else:
					tween.tween_property(self, "global_position", initialPos,0.1).set_ease(Tween.EASE_OUT)

func _on_area_2d_body_entered(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = true
		body_ref = body
		body_color = body.color

func _on_area_2d_body_exited(body):
	if body.is_in_group('dropable'):
		is_inside_dropable = false

func _on_area_2d_mouse_entered():
	if !GameManager.isDragging and !already_placed:
		draggable = true
		scale = Vector2(1.1,1.1)

func _on_area_2d_mouse_exited():
	if !GameManager.isDragging:
		draggable = false
		scale = Vector2(1,1)
