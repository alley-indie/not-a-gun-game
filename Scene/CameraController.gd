extends Camera2D

onready var player = get_node("/root/Level/YSort/Player")

func _process (delta):
  if not has_node('/root/Level/YSort/Player'):
    return
  if player.position.x > 160:
    position.x = player.position.x
