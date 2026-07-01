extends CharacterBody2D

# --- STATS (Change these in the Inspector!) ---
@export var max_hp: int = 3
@export var damage: int = 5
@export var speed: int = 150 

var current_hp: int
var player = null
var can_attack = true 

func _ready():
	# 1. Your original player tracking
	player = get_parent().get_node("Player")
	
	# 2. The new Health Bar setup
	current_hp = max_hp
	$HealthBar.max_value = max_hp
	$HealthBar.value = current_hp

func _physics_process(delta):
	# Your exact movement code
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed # Now uses the exported speed!

		var collision_data = KinematicCollision2D.new()
		
		if test_move(global_transform, velocity * delta, collision_data):
			if collision_data.get_collider() != null and collision_data.get_collider().name == "Player":
				velocity = Vector2.ZERO
				
				# Your exact attack cooldown code
				if can_attack:
					# Now uses the exported damage instead of a hardcoded 5!
					collision_data.get_collider().take_damage(damage) 
					can_attack = false
					await get_tree().create_timer(1.0).timeout
					can_attack = true
				
		move_and_slide()
		
func take_damage(damage_amount):
	current_hp -= damage_amount
	$HealthBar.value = current_hp # Updates the red bar when hit
	
	if current_hp <= 0:
		queue_free()
