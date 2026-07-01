extends CharacterBody2D

var hp = 3 
const SPEED = 150.0 
var player = null
var can_attack = true 

func _ready():
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED

		var collision_data = KinematicCollision2D.new()
		
		if test_move(global_transform, velocity * delta, collision_data):
			if collision_data.get_collider() != null and collision_data.get_collider().name == "Player":
				velocity = Vector2.ZERO
				
				if can_attack:
					collision_data.get_collider().take_damage(5)
					can_attack = false
					await get_tree().create_timer(1.0).timeout
					can_attack = true
				
		move_and_slide()
		
func take_damage(damage_amount):
	hp -= damage_amount
	if hp <= 0:
		queue_free() # Only delete the deer if HP hits 0
