extends CharacterBody2D

const SPEED = 180.0

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
	if is_game_over:
		return
		
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	
	# ... your existing movement code ...
	move_and_slide()
	
	# --- THE SWORD ATTACK ---
	# "ui_accept" is the Spacebar (or Enter) by default
	# --- THE SWORD SWING & ATTACK ---
	if Input.is_action_just_pressed("ui_accept"):
		
		# 1. THE ANIMATION (Swings the sword 90 degrees, then pulls it back)
		var tween = create_tween()
		tween.tween_property($WeaponPivot, "rotation", 1.5, 0.1) # Swing out fast
		tween.tween_property($WeaponPivot, "rotation", 0.0, 0.15) # Pull back normal
		
		# 2. THE DAMAGE (Notice the new path to the hitbox!)
		var things_hit = $WeaponPivot/SwordHitbox.get_overlapping_bodies()
		
		for body in things_hit:
			if body.is_in_group("enemy"):
				# Instead of deleting them, we trigger the deer's new damage function
				if body.has_method("take_damage"):
					body.take_damage(1) # Deals 1 damage per swing

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
