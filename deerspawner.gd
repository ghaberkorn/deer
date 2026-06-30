extends Node2D

var deer_scene = preload("res://enemy_deer.tscn")

func _on_timer_timeout():
	var new_deer = deer_scene.instantiate()
	
	# Randomizes positions strictly within our new non-zero arena
	var random_x = randf_range(150, 1650)
	var random_y = randf_range(150, 1250)
	
	new_deer.position = Vector2(random_x, random_y)
	get_parent().add_child(new_deer)
