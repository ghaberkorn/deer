extends Node2D

# 1. THE BLUEPRINT: This tells the spawner exactly which file to copy.
var coin_scene = preload("res://yen_coin.tscn")

# 2. THE TRIGGER: _ready() runs automatically the split-second the level starts.
func _ready():
	# This is a loop. It tells the game to run the code below it 20 times.
	for i in range(20):
		spawn_coin()

# 3. THE ACTION: A custom function that builds one single coin.
func spawn_coin():
	# Instantiate creates a physical clone of the blueprint.
	var new_coin = coin_scene.instantiate()
	
	# randf_range picks a random number between two values.
	# We use this to pick a random X (left/right) and Y (up/down) coordinate.
	var random_x = randf_range(-3000, 3000)
	var random_y = randf_range(-3000, 3000)
	
	# Set the coin's position to those random coordinates.
	new_coin.position = Vector2(random_x, random_y)
	
	# add_child is the most important part! It actually drops the coin into the game.
	add_child(new_coin)
