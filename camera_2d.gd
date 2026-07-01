extends Camera2D

func _ready():
	# Tells the minimap to look at the same physical world Kai is in
	get_parent().world_2d = get_tree().root.world_2d

func _process(_delta):
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		global_position = players[0].global_position
