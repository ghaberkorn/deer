extends StaticBody2D

var current_player = null

func _ready():
	$MenuLayer.visible = false

# When Kai walks into the big collision box
func _on_shop_zone_body_entered(body):
	if body.name == "Player":
		current_player = body
		$MenuLayer.visible = true # Show menu

# When Kai walks away
func _on_shop_zone_body_exited(body):
	if body.name == "Player":
		current_player = null
		$MenuLayer.visible = false # Hide menu

# When you click the Health button
func _on_btn_health_pressed():
	if current_player != null:
		# Tries to spend 5 Yen. If true, heal 20 HP!
		if current_player.spend_yen(5):
			current_player.heal(20)
			print("Bought Health!")

# When you click the Speed button
func _on_btn_speed_pressed():
	if current_player != null:
		# Tries to spend 10 Yen. If true, boost speed!
		if current_player.spend_yen(10):
			current_player.boost_speed(50.0)
			print("Bought Speed!")
