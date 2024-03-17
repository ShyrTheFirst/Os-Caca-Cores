extends CharacterBody2D


var dragging : bool = false 

var color : Color
  
var gravity = 0
var distance : float = 0.0
var direction : Vector2 = Vector2.ZERO
var speed : float = 50.0

func _ready():
	modulate = color
	
func _process(delta):
	
	if dragging:
		scale = Vector2(0.5,0.5)
		var current_position : Vector2 = global_position
		var mouse_position : Vector2 = get_global_mouse_position()
		
		distance = current_position.distance_to(mouse_position)
		direction = current_position.direction_to(mouse_position)
		speed = distance * delta * 500.0
		
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, 50)
		velocity.y = move_toward(velocity.y, 0, 50)
	
	move_and_slide()
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and dragging and not event.is_pressed(): #Detect mouse click, maybe mapping would be better
		dragging = false
		
func _on_Draggable_input_event(_viewport:Node, event : InputEvent, _shape_idx:int): #input_event signal from characterbody2d
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.is_pressed()


func _on_mouse_entered():
	if !dragging:
		scale = Vector2(0.7,0.7)


func _on_mouse_exited():
	scale = Vector2(0.5,0.5)
