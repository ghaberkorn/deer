extends CharacterBody2D

var SPEED = 250

#in order to playtest change speed to 300 or 500, default for player should be 180

var yen = 0
var hp = 100
var is_game_over = false

@onready var coin_label = $CanvasLayer/CoinUI
@onready var hp_label = $CanvasLayer/HPUI
@onready var game_over_screen = $CanvasLayer/GameOverScreen

func _ready():
	hp_label.text = "HP: " + str(hp) + "/100"
	coin_label.text = "Yen: " + str(yen)
	game_over_screen.hide()

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	# --- AUTOMATIC SWORD FLIP -- -
	# If walking right, hold sword in the right hand
	if direction.x > 0:
		$WeaponPivot.scale.x = 1
	# If walking left, mirror everything to the left hand
	elif direction.x < 0:
		$WeaponPivot.scale.x = -1
		
	move_and_slide()
	
	# --- THE COMPASS ARROW ---
	var goals = get_tree().get_nodes_in_group("goal")
	if goals.size() > 0:
		# Calculates the exact mathematical angle between Kai and the Buddha
		var target_pos = goals[0].global_position
		$CompassPivot.rotation = global_position.direction_to(target_pos).angle()
	
	# --- THE SWORD SWING & ATTACK ---
	if Input.is_action_just_pressed("ui_accept"):
		var tween = create_tween()
		tween.tween_property($WeaponPivot, "rotation", 1.5, 0.1) 
		tween.tween_property($WeaponPivot, "rotation", 0.0, 0.15) 
		
		var things_hit = $WeaponPivot/SwordHitbox.get_overlapping_bodies()
		
		for body in things_hit:
			if body.is_in_group("enemy"):
				if body.has_method("take_damage"):
					body.take_damage(1)

func collect_yen():
	yen += 1
	coin_label.text = "Yen: " + str(yen)

func take_damage(damage_amount):
	if is_game_over:
		return
		
	hp -= damage_amount
	if hp < 0: 
		hp = 0
	hp_label.text = "HP: " + str(hp) + "/100"
	
	if hp <= 0: 
		trigger_game_over()

func trigger_game_over():
	is_game_over = true
	print("GAME OVER")
	
	game_over_screen.show() 
	await get_tree().create_timer(2).timeout 
	
	get_tree().quit()

# Checks if Kai has enough money, and spends it if he does
func spend_yen(cost):
	if yen >= cost:
		yen -= cost
		$CanvasLayer/CoinUI.text = "Yen: " + str(yen) # Updates your existing UI!
		return true
	return false

# The Health Drink effect
func heal(amount):
	hp += amount
	if hp > 100: 
		hp = 100 # Prevents going over max health
	$CanvasLayer/HPUI.text = "HP: " + str(hp) + "/100"

# The Speed Drink effect
func boost_speed(amount):
	# Using SPEED here instead of const SPEED (Note: you may need to change 
	# 'const SPEED = 180.0' at the top of your script to 'var SPEED = 180.0' so it can change!)
	SPEED += amount
