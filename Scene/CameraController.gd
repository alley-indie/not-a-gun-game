extends Camera2D

onready var player = get_node("/root/Level/YSort/Player")

func _process (delta):
  if not has_node('/root/Level/YSort/Player'):
    return
  position.x = player.position.x
