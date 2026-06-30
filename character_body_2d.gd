extends CharacterBody2D

const SPEED = 300.0

var yen = 0
var hp = 100

@onready var coin_label = $/root/MainMap/Player/CanvasLayer/CoinUI
@onready var hp_label = $/root/MainMap/Player/CanvasLayer/HPUI


func _ready():
	hp_label.text = "HP: " + str(hp) + "/100"
	coin_label.text = "Yen: " + str(yen)


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

func collect_yen():
	yen += 1
	coin_label.text = "Yen: " + str(yen)

func take_damage(damage_amount):
	hp -= damage_amount
	if hp < 0: hp = 0
	hp_label.text = "HP: " + str(hp) + "/100"
	if hp == 0: print("GAME OVER")
