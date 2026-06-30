extends CharacterBody2D

const SPEED = 150.0 

var player = null

func _ready():
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if player != null:
		# Check the actual distance between the deer and the player
		var distance_to_player = global_position.distance_to(player.global_position)
		
		# If the deer is further than 40 pixels away, keep chasing
		if distance_to_player > 40.0:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * SPEED
		# If the deer is close enough, stop moving completely
		else:
			velocity = Vector2.ZERO
		
		move_and_slide()
