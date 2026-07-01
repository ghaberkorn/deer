extends Node

# Load all three files
var female_scene = preload("res://deer_female.tscn")
var normal_scene = preload("res://enemy_deer.tscn")
var scary_scene = preload("res://deer_scary.tscn")

# Put them in a list
var deer_roster = [female_scene, normal_scene, scary_scene]

func _on_timer_timeout():
	# Pick a random deer from the roster
	var random_deer_scene = deer_roster.pick_random()
	var new_deer = random_deer_scene.instantiate()
	
	var random_x = randf_range(200, 6000)
	var random_y = randf_range(200, 6000)
	
	new_deer.position = Vector2(random_x, random_y)
	get_parent().add_child(new_deer)
