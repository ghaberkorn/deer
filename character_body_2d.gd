extends CharacterBody2D

# This sets the movement speed.
const SPEED = 300.0

var yen_count = 0

func collect_yen():
	yen_count += 1
	print("Yen collected! Total Yen: ", yen_count)
	
# _physics_process runs every single frame of the game.
func _physics_process(delta):
	# Input.get_vector automatically checks the WASD or Arrow Keys 
	# and creates a 2D Vector (X and Y coordinates) based on what you press.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Multiply the direction by our speed to set the velocity
	velocity = direction * SPEED
	
	# This built-in function actually moves the character and handles hitting walls
	move_and_slide()
	
	
