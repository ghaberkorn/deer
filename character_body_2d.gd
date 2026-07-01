extends CharacterBody2D

const SPEED = 300.0

var yen = 0
var hp = 100

@onready var coin_label = $CanvasLayer/CoinUI
@onready var hp_label = $CanvasLayer/HPUI


func _ready():
	hp_label.text = "HP: " + str(hp) + "/100"
	coin_label.text = "Yen: " + str(yen)


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	
	# ... your existing movement code ...
	move_and_slide()
	
	# --- THE SWORD ATTACK ---
	# "ui_accept" is the Spacebar (or Enter) by default
	if Input.is_action_just_pressed("ui_accept"):
		
		# Get a list of every physics body currently touching the sword box
		var things_hit = $SwordHitbox.get_overlapping_bodies()
		
		# Check them one by one
		for body in things_hit:
			# If the thing has the "enemy" tag we just made...
			if body.is_in_group("enemy"):
				body.queue_free() # Delete the deer instantly

func collect_yen():
	yen += 1
	coin_label.text = "Yen: " + str(yen)

func take_damage(damage_amount):
	hp -= damage_amount
	if hp < 0: hp = 0
	hp_label.text = "HP: " + str(hp) + "/100"
	if hp == 0: print("GAME OVER")
