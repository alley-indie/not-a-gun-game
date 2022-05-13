extends Camera2D

onready var player = get_node("/root/Level/YSort/Player")
#This function gets called every frame
func _process (delta):
  if not has_node('/root/Level/YSort/Player'):
    return
  position.x = player.position.x
