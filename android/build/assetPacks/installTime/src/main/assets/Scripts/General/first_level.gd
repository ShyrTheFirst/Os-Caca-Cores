extends Node2D

const COLOR_OBJECTS_EASY = preload("res://Scenes/EasyLevels/color_objects_easy.tscn")
var color_list = [Color.RED, Color.GREEN, Color.BLUE]

func _ready():
	randomize()
	
	for i in range(randi_range(6,12)):
		var create_object = COLOR_OBJECTS_EASY.instantiate()
		create_object.position = Vector2(randi_range(200,300),randi_range(200,300))
		create_object.color = color_list.pick_random()
		GameManager.easy_mode_objects += 1
		add_child(create_object)

func _process(_delta):
	if GameManager.easy_mode_objects == 0:
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
